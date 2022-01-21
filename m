Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BF496448
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiAURnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 12:43:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14600 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381861AbiAURmF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 12:42:05 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LFOtxe030526
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:42:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Bz78JfwWjGJ4pBT0jPDNxLvllwwcf7AGTgAg/kyoE1w=;
 b=rl8uStR1gtTPo6ay0wGkVvOxgIdhN2u7H4bIDW36z+rg95N5EGgqb1TZ4gwsRVWwKUBS
 /7LF2RZ7kyg8PNdL4ltCEXXCMCgw2lB/5k0G7rOt3e03GskeO8+HpVm9M1EaiRayd3Hk
 RPLJycuimvxmUzAFIuCMz7VOUCLu/fiGo5Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqhyr4pfc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:42:03 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 09:42:01 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 9A9E695B769A; Fri, 21 Jan 2022 09:41:53 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kennyyu@fb.com>, <phoenix1987@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Fri, 21 Jan 2022 09:41:45 -0800
Message-ID: <20220121174145.3433628-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEf4Bzaen2f2njYOAJuyWot2YvXn0YV=2zBVyFZw=_CqJdggPw@mail.gmail.com>
References: <CAEf4Bzaen2f2njYOAJuyWot2YvXn0YV=2zBVyFZw=_CqJdggPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0YlLqql1sWGYZj_3pFffaTHAglWMhAbd
X-Proofpoint-GUID: 0YlLqql1sWGYZj_3pFffaTHAglWMhAbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > How about bpf_copy_from_user_task() ?
> > The task is the second to last argument, so the name fits ?
>=20
> yeah, I like the name

I'll change the name to `bpf_copy_from_user_task`.

> > Especially if we call it this way it would be best to align
> > return codes with bpf_copy_from_user.
> > Adding memset() in case of failure is mandatory too.
> > I've missed this bit earlier.
>
> Yep, good catch! Seems like copy_from_user() currently returns amount
> of bytes *not* read and memsets those unread bytes to zero. So for
> efficiency we could probably memset only those that were read.
>
> > The question is to decide what to do with
> > ret > 0 && ret < size condition.
> > Is it a failure and we should memset() the whole buffer and
> > return -EFAULT or memset only the leftover bytes and return 0?
> > I think the former is best to align with bpf_copy_from_user.
>
> Yeah, I think all or nothing approach (either complete success and
> zero return, or memset and error return) is best and most in line with
> other similar helpers.

Thanks for the suggestions! I'll go with the all-or-nothing approach to
be consistent with `bpf_copy_from_user` and will make the following chang=
es:

* Return value: returns 0 on success, or negative error on failure.
* If we had a partial read, we will memset the read bytes to 0 and return
  -EFAULT

> Another thing, I think it's important to mention that this helper can
> be used only from sleepable BPF programs.

Will add that to the docs.

> > That would be difficult. There is no suitable kernel api for that.
>
> Ok, but maybe we can add it later. Otherwise it will be hard to
> profiler Python processes and such, because you most certainly will
> need to read zero-terminated strings there.

I will NOT add a C string helper in this patch series, and I'll explore
how to add this in the future once this patch series is merged.

> > +       skel =3D bpf_iter_task__open_and_load();
> > +       if (CHECK(!skel, "bpf_iter_task__open_and_load",
> > +                 "skeleton open_and_load failed\n"))
>
> Please use ASSERT_OK_PTR() instead.

Will fix.

> > +       numread =3D bpf_access_process_vm(&user_data,
> > +                                       sizeof(uint32_t),
> > +                                       ptr,
> > +                                       task,
> > +                                       0);
>
> nit: keep it on one line (up to 100 characters is ok)

Will fix.

Thanks for the suggestions everyone!

Kenny
