Return-Path: <bpf+bounces-70225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF3BB4D7F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05BE19C31B4
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5EA275B0D;
	Thu,  2 Oct 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5bEcIVn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88226F287
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428583; cv=none; b=YXsdv8bUisO6KxbZm1W+9EPAWcOMswfpjb/GaGrF7mFKkf2glg7M53UZ2s8MSojSdrxiuHAq2kUuhcvByLzY46g6rseNr62xKDZYjQmTT3P9XV5ww/FYPWNWL2zlJdMPezErAK3RQf2xu9Sea7SwvKNXT/Bg6/kaZBCoaY3IOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428583; c=relaxed/simple;
	bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj3qEJekLAo0d5aMiZHfQI66JIAR5GB2cwBNAYcS2H+JK+pBNCdfJJGHFBllHmZggRJ6MbMrshsw0qdnDO+3/stKtMY5P/SbzAoPqZ26e49W8xCaKlvKcd283h51D/+EHxY0hzO5XSp3/rjVD2fz5or4w0KEMsY5BjghtCQt4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5bEcIVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929FbgT032145
	for <bpf@vger.kernel.org>; Thu, 2 Oct 2025 18:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=; b=V5bEcIVnpEEGSW/K
	sswMJNBXvlTgsDi0tXuhJnoWZcHHhYt6TaH/F7svLIzzs9tWuFhizbWjettpnoN8
	3OP6TYD9t9fP5dtbI234ciJJskTjhipA4pOHGMhGTZqgjACRjq83/3uwcPDto74X
	G2LFep8V4Rx5cVk6CSFtAmgV1cSwpAmmPbwLrrM74k6QWDHmS9LtdbQwfXVeCaI8
	P6nky/iaAtcsH8d4JzBx0zNj3yqOPXZUZ5qM6Hd50wV7G67sxW70M6JBEJjw3qcy
	EHAlRKuIVhl+eLU5nKN8Cbr89wqtW39rFbVEE73tUaYtmET2OnvuSUVM59XdzIdV
	jO8SvQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr8m25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 18:09:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee214108cso29013625ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 11:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428581; x=1760033381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
        b=tDlnBxIsSTCnZt8GXKFdBWiLerrdXAnsu0j+XjpGdmpMs/MAVew5MjjEVQM3fi7ThI
         bNU3q8yV/Gs19LD57LDUIpGrf4/8tl0XVUI3AhL/Y/kNVvHD7vAbao2kqaoE7mFmQCQK
         mJg/BAxuSBjTS2t5ljAZI+FafYV8pW3w/vpALpecv0fXsYRM2kJMWhtIXie5vbZRgvu2
         w4LWc3MOUN6RCNSOvEC0IU53MEViNdYz12i57dknOt1/pR2DuOs1d/vNuoKgF60gLTWB
         n3icHKetlozZ2jG5d5d9cZCCFWHFwYlJnMMk/SHxoi4FcTFsQVQa5uHwBM6in/tlxR8k
         jHnA==
X-Forwarded-Encrypted: i=1; AJvYcCVUG3Q4QzvgrPEWxs2VVD7oG8UZSTb7zFuNrTwZ8h7Eh+C1Z5oF95mxIMw+rI6ptVnVo6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5m/5boG4EgI9R5vyqjX98zOqxMhBMpRcDzbmx/f8RfLKq18x
	Y3yHFBAEutxrmsCydTrheLxkOTTz4htZBw5T9EDsX0iMMwQ9qIweUYsqVTAmChvNp4KBGW2U6II
	pa4NcALnSmxASPkZRwntEVPgVuo+bRKzwWIqmw6fDKOosGYnvilMcUkACYH2aTuFxLChKgTfS2x
	hBfGcNZhjh6M8t8TQ36/Y3aT2oP1+rBA==
X-Gm-Gg: ASbGncsdX12sSatSn4bRLHd4t62xVP992alPh+qSsiqZny92yeOPkOczXdcTOF2vf+j
	tqMEDm5AJcX0DuW0fN2IMh+5hJen1m0i/ZiSnTtEuC/+8lLQYSgGWnWT+feUlbmZvdTcBe9TtfH
	GOdtCBH1RzQuBMjv8igzs96SA9NO0=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-28e9a7031c4mr1578885ad.61.1759428580615;
        Thu, 02 Oct 2025 11:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp+nzr4kOaiK9pHKoBe7y+pNgMV1+KMM5h/aSQpFMdxD2b/L9xkPrqEo1lFclOnfCQtSnXjjCgAmMou37yiBw=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-28e9a7031c4mr1578615ad.61.1759428580113; Thu, 02 Oct 2025
 11:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com> <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev> <aN629m1MlMXYh1te@x1>
 <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
 <aN69RSQQ8agXOBDH@x1> <87wm5dtc7q.fsf@gentoo.org>
In-Reply-To: <87wm5dtc7q.fsf@gentoo.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:09:28 -0700
X-Gm-Features: AS18NWBnpmJoQOPbNXZCG7gxNfGYH9tAmT0-_sb-ZrHu9aZmPY32BVGyYsUoNW8
Message-ID: <CALvbMcC3fT8sz=45Ncf_Lydyyas57Jje-erLBKTaM-m87+jbLQ@mail.gmail.com>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC compatibility
To: Sam James <sam@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Pinski <apinski@quicinc.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 0A2PzuLV5YqPmBz4LXpptR2qUsNZa7xt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXxLfZ8TTAo9dq
 rXxyNVfVkdKM/W2cJ+ePcrkABzVc/u3d8HisYVRI19wNDpQ6j9C/NxWcZzoxjmh3VGDpI1LtSRX
 n+qeFxbPB7MSRDK/EEcIc1ysED6iePjQMyKemKqVgu3+1T162AQheNxl2Y3rlsUF91su8ZTU1rs
 GjWjG7AfYq0slsQt8yLuIwvFDC9Y1tB9yT1K2iUyH2ejMMUtRoU0FpyiODfIPlXugPA7YSghsaw
 WFFFl6p6D2QZb1K6nJsDvA3dT8UkLGvWltxOnqkwoH8Nd8GjJvCGLhjMTsAMEmuOrHm/KajdXof
 rHevMrtIBAmEI3HxJbVzkBft1sLwCCrpxWfxkFlJULl6h9/0rwrHQeywZ59pIYn0cXsZMXpppww
 wWm2NqT52/I5V3/RUxdh83AeiQY6BA==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68debfe5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nzY_nJytDTGGSvjW54AA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=wa9RWnbW_A1YIeRBVszw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0A2PzuLV5YqPmBz4LXpptR2qUsNZa7xt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On Thu, Oct 2, 2025 at 11:01=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> > On Thu, Oct 02, 2025 at 05:35:09PM +0000, Andrew Pinski wrote:
> >> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> > So I'm taking the patch as-is, ok?
> >
> >> > But first we need the Signed-off-by tag from Andrew Pinski as
> >> > he is listed in a Co-authored-by, that I replaced with Co-
> >> > developed-by as its the term used for this purpose in:
> >
> >> > Yonghong, can I add an Acked-by: you since you participated in
> >> > this discussion agreeing with the original patch (If I'm not
> >> > mistaken)?
> >
> >> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> >
> >> Note my email address for doing Linux and GCC development is
> >> Andrew.pinski@oss.qualcomm.com . It was apinski_quic@quicinc.com but
> >> that changed last month.
> >
> > This is what I have in the patch now:
> >
> > Co-developed-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
>
> Looks good if Andrew is happy. Thanks!

I am.

>
> >
> > - Arnaldo

