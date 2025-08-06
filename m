Return-Path: <bpf+bounces-65118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD000B1C4EE
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81995625D1B
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673C28A414;
	Wed,  6 Aug 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJBEF5vG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3925B66A;
	Wed,  6 Aug 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479800; cv=none; b=CTKam3yYB9sn3qh3htSq2uX9Xxvww0+BLffEMXO3YDH8gXvIa3bvdqNdazvjcezhbtEFk6XOdubMMBqgnEW5S8oZqyW63ZFqdHzKAeUpiqZdogPgdetPRBqHTVQwsHFNMV+naN9R7vnboChCADosO5gn63cugNi5xhl/CKMFPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479800; c=relaxed/simple;
	bh=lXxGjaqxd4CR1EycdnQYnZEdyBTLW4aFYI0WMkr8IDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G607ycwe1eUtIymLh/MgrJEUjmRSvw48HxFtEywamdwOXnJ19viEvT2ywq8PNXmlYmRDP6cjrhuS9JOVSsaV9rDtXVXP7GNapiBW5I0aSb0b7Ps04BBD5TZ0WyJOImy78RDMS/Mz29AVm0e1cL10XYE5feESPvUQ7mbXmp3v8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJBEF5vG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57684lUB028218;
	Wed, 6 Aug 2025 11:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lXxGja
	qxd4CR1EycdnQYnZEdyBTLW4aFYI0WMkr8IDU=; b=fJBEF5vGQYKG9qB/YDwoxM
	MNTHafF3RQ24jE+uO1aYs4jhjNxqk7fSpBfJXmuc6kCY3J+VfRUWvikreZbScDBY
	5EwrJdTsplilqYw5WqWNYr8jSW8eqYAbCGf80RRJJF3CZHnan1357YPoAfTIRJyB
	7Lk4JTfiNXdmr1Hk5bLQbk2WxPfoV61+67JYev9d6NCETCNKvsX2pXVDDhu6UTSr
	pC43DOduP49IIpEXvk+m6Duk7A1dogU2eQeMw+VsQkman1BF+BXP+Ugh/LF6BXsA
	QpFH2bgjPuyL0PZcaeQ/sIiLig1d/dR7NjgNTLH8mVDRwJH+6+gZCKePFj0OWDeA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60uva4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:29:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576805q6001574;
	Wed, 6 Aug 2025 11:29:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqubmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:29:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576BTrIf46465348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 11:29:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28C820040;
	Wed,  6 Aug 2025 11:29:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 035DF2004B;
	Wed,  6 Aug 2025 11:29:52 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 11:29:51 +0000 (GMT)
Message-ID: <560548ac0ca1f7be7cfb77e34745f86075df2f41.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] perf bpf-filter: Enable events manually
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Gordeev
	 <agordeev@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers
 <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Jiri Olsa	
 <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>
Date: Wed, 06 Aug 2025 13:29:51 +0200
In-Reply-To: <1094385e-6f86-453f-a48e-fa284dcae385@linux.ibm.com>
References: <20250805130346.1225535-1-iii@linux.ibm.com>
	 <20250805130346.1225535-3-iii@linux.ibm.com>
	 <4a7fc5ab-682d-4fac-a547-9e4b1263dba7-agordeev@linux.ibm.com>
	 <1094385e-6f86-453f-a48e-fa284dcae385@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 97x1FuJDSp1d4OU08MjnD0Zz4dogtLNu
X-Proofpoint-ORIG-GUID: 97x1FuJDSp1d4OU08MjnD0Zz4dogtLNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3MSBTYWx0ZWRfXx+1Jgl1bZtfN
 hWg/n2yPk9ikIhV+KpGJ833xX4WNg3Kp2YSdQrRUUs7Q92zj+5mi2RWcBfioY+v73fwIetdTMDq
 jKUJblciv6aeQRVvTF1uIim2ofNEaeC5yA+FNnjuEy548DLc4MyYLuM8n+HlQMSGNQWC2vLUVzt
 +MHgL38uStopU1+L1vNFso33RxiODnEM1a5rpOXr4Q7JO+vN5VIQ4eFH0shI03jKbctdSuwRgIE
 JJq59ZE1XDR2MQDQCkuNRIL0qL+xwHkQnnEWnq44mrg7ZOxzoFpGqDuRPXd9n4My/o8TLu3EIFN
 xaE1mZCUAm7lm6MCI+766TGNSAyo4oyDppdwDDrw/jq2PhCRoIAlbC9l5Tj3PxUw4YgHJyA2bZ0
 bI0Jp0rsfytdp1I3xMjaz2eWlGHNUBl3LLU92dXesUGZWitpNU37TuXDrZd+AUL5vfA0Yoqy
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68933cb6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=UvtTZARwlCIvicOQcdAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060071

On Wed, 2025-08-06 at 11:29 +0200, Thomas Richter wrote:
> On 8/5/25 16:14, Alexander Gordeev wrote:
> > On Tue, Aug 05, 2025 at 02:54:05PM +0200, Ilya Leoshkevich wrote:
> >=20
> > Hi Thomas,
> >=20
> > The below comments date to the initial version, so the question is
> > rather to you:
> >=20
> > > On linux-next
> >=20
> > This line is extra.
>=20
> I just wanted to let readers know which repo to look at.
>=20
> >=20
> > > commit b4c658d4d63d61 ("perf target: Remove uid from target")
> > > introduces a regression on s390. In fact the regression exists
> > > on all platforms when the event supports auxiliary data
> > > gathering.
> >=20
> > So which commit it actually fixes: the above, the below or the
> > both?
> >=20
> > > Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF
> > > program to perf event")
> >=20
> > Thanks!
> >=20
>=20
> Good question!=C2=A0 Pick what you like... :-)
>=20
> The issue in question originates from a patch set of 10 patches.
> The patch set rebuilds event sample with filtering and migrates
> from perf tool's selective process picking to more generic eBPF
> filtering using eBPF programs hooked to perf events.
>=20
> To be precise, the issue Ilya's=C2=A0 patch fixes is this:
> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF
> program to perf event")
>=20
> However the issue (perf failure) does *NOT* show up until this patch
> is applied:
> commit b4c658d4d63d61 ("perf target: Remove uid from target")

I think I will switch the Fixes: tag to b4c658d4d63d61 then, because
IIUC it is one of the factors that drives backporting decisions, and
it does not make too much sense to backport it to earlier kernels.

> There are some patches in between the two (when you look at the
> complete patch set),
> but they do not affect the result.
>=20
> Hope that helps.

