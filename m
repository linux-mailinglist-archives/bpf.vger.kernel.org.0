Return-Path: <bpf+bounces-9149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B352E790B37
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8232A2813E3
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662D917F4;
	Sun,  3 Sep 2023 08:23:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160115A7
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:23:47 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DD136
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 01:23:46 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3838J4xi021292;
	Sun, 3 Sep 2023 08:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sH7llzHlTaaQy9z36rJMBA+LvNQ7lRRBsAmSk2kM0ac=;
 b=MQpPVrzVpK+oipqP0LjByhslgxpkJRnErRUnlbcguhod+A7/uvH4ON0lhSQPj6zfFomk
 haRGpLdSoTuHSnZpmK2jLT8O53+mzCDv/VA+CyBApwYwVab116ftVMkmsIBsajArgJ3p
 BluICh/Ka+oZ70qB3Fh8Ko+/gykqTz4UL55+N1Ay/eH81waSo/Q2UyTEkP9WxlF8M4Mn
 BxTaCdi0A0r6YoS5snX/2xmvJj6GBGTL0B9HyVklIrDILxTaEReC4qfCvAtDT47Q9aRr
 A7Rn6v64Ode4+0plmbhLEZboq+HT+YlzACW5u3VwnBypXk3rVIIWmjnX2y/FrHCt8f4L pg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svphb81ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Sep 2023 08:23:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38387Dvm006668;
	Sun, 3 Sep 2023 08:23:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvjsuq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Sep 2023 08:23:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3838NOAj43319800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Sep 2023 08:23:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4AC520043;
	Sun,  3 Sep 2023 08:23:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38FE220040;
	Sun,  3 Sep 2023 08:23:24 +0000 (GMT)
Received: from [9.171.29.233] (unknown [9.171.29.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Sep 2023 08:23:24 +0000 (GMT)
Message-ID: <f7cdb053779c7b47042fbb7a5ba46edc67b9aa8f.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 02/11] net: netfilter: Adjust timeouts of
 non-confirmed CTs in bpf_ct_insert_entry()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, fw@strlen.de,
        pablo@netfilter.org
Date: Sun, 03 Sep 2023 10:23:23 +0200
In-Reply-To: <08f2e910-2bd8-8cf6-688b-4bdf0161c969@iogearbox.net>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
	 <20230830011128.1415752-3-iii@linux.ibm.com>
	 <08f2e910-2bd8-8cf6-688b-4bdf0161c969@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fVoI2X_sfE7vipjeJnGmlRsu6ocgzd7B
X-Proofpoint-ORIG-GUID: fVoI2X_sfE7vipjeJnGmlRsu6ocgzd7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309030074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-31 at 17:30 +0200, Daniel Borkmann wrote:
> [ +Florian ]
>=20
> On 8/30/23 3:07 AM, Ilya Leoshkevich wrote:
> > bpf_nf testcase fails on s390x: bpf_skb_ct_lookup() cannot find the
> > entry that was added by bpf_ct_insert_entry() within the same BPF
> > function.
> >=20
> > The reason is that this entry is deleted by nf_ct_gc_expired().
> >=20
> > The CT timeout starts ticking after the CT confirmation; therefore
> > nf_conn.timeout is initially set to the timeout value, and
> > __nf_conntrack_confirm() sets it to the deadline value.
> > bpf_ct_insert_entry() sets IPS_CONFIRMED_BIT, but does not adjust
> > the
> > timeout, making its value meaningless and causing false positives.
> >=20
> > Fix the problem by making bpf_ct_insert_entry() adjust the timeout,
> > like __nf_conntrack_confirm().
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> Should we route this fix via bpf tree instead? Also, could you reply
> with
> a Fixes tag?

Yes, putting this into the bpf tree makes sense to me. Should I resend
with a different subject-prefix?

Fixes: 2cdaa3eefed8 ("netfilter: conntrack: restore IPS_CONFIRMED out
of nf_conntrack_hash_check_insert()")

[...]


