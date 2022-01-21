Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BF49650E
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382103AbiAUSa5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 13:30:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351379AbiAUSaz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 13:30:55 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LGKTIG010980
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 10:30:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wbjjILlQtcR2nu9yI2P6QWxjTBHgnHQKYHuaav40Aqo=;
 b=XAq/NU8JTAqCUsZMixUBg00U/oCXrpB/H5bZp5g0uAsNKucWs/wXly7JvwuklXiHRYcQ
 Ty9scmuCprpL7YV1MVUhQ5tWfzadtkRjWKnni6NUej7j79yycsKcllWUqXLPkRdjr8FW
 ZlDDfzRlvIT8wvqmrAHr3Aqjz5QOyOx2Vog= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqj0gmxk4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 10:30:55 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 10:30:52 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 56EA695BF46C; Fri, 21 Jan 2022 10:30:48 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii.nakryiko@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <kennyyu@fb.com>,
        <phoenix1987@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Fri, 21 Jan 2022 10:30:44 -0800
Message-ID: <20220121183044.945054-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAADnVQKZa_rm3sybP=Rt4Nm-zYrv4s9XvF7PGDFTOBD-TDu23g@mail.gmail.com>
References: <CAADnVQKZa_rm3sybP=Rt4Nm-zYrv4s9XvF7PGDFTOBD-TDu23g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sGSV7XDWVCiz_djwq0VhtN67nGqnUH9e
X-Proofpoint-GUID: sGSV7XDWVCiz_djwq0VhtN67nGqnUH9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=833 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > * If we had a partial read, we will memset the read bytes to 0 and re=
turn
> >   -EFAULT
>=20
> Not read bytes, but all bytes.
> copy_from_user zeros leftover for us, but access_process_vm doesn't
> do this on partial read.

I'll memset all bytes on error. Thanks for the suggestion!

Kenny
