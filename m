Return-Path: <bpf+bounces-70212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BFBB4712
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAF3B3781
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D024169A;
	Thu,  2 Oct 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpsB+ac3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73828151991
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421256; cv=none; b=MvV0EZBkDCnSBpdaitJWH9nH+2qNnMXKBOJUp30OASdE8OsMz9VuqQjI83TR52anXnFXgMzFkciOnzW1/OqhDKuItDaH4KC3yxRixuS9YjvOPRNwZMfnWj9yCr6XKmfagjz7jmNHn30gAAL6VPHFszW7SVtBFuKgWFyz+mCfqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421256; c=relaxed/simple;
	bh=ANoZPM4Goe8kEJ7+459YkV2zGlgB+F923GyCVd9vx/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPTbVSkvTGL2E3JMSdmZgLOWMzBvWPb+hKMRgRr5W4aANWhBO2lvLLY4eFD/+i/1Te+zCv6z++AHMyBE5sxsn5+I5aESwxiX3wu0TQOftkvekSUi0B/6MBs80ypJSgvVvFVPsGnabWFl5vhURF3xGyVrLEnFXn+H3VYU/2ZMxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpsB+ac3; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6354a4b4871so1466975d50.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421253; x=1760026053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAay7WQAYhXYn/E/OMo5YGGzkwYxNsk2ckJPOjY/KOo=;
        b=bpsB+ac3rAGdKNsVpgAW7riWi3wzNOsxUsST5iwNofEFQnt823DCZEz8RtCR3/Xj4n
         5e9eeSZMXJhiodFMg2K/S7TC5DlMbMMsHZc+J1A/67QEDG5WqAfjE79ys9gAbsHU8W6Q
         h0EBIvrrYytx8+yAGawTAklXMLSMcQqmbJ3iTLITXl/bnA0qf26JZYHMLK1OmCsxa0Ud
         0hx6GxqRoeotwIbs5ESE5faeetq5lryfNVG05FTTo6mxGsZYK+Cr6eSpUVIfBoKyyscP
         MyWhMJxcyPjrvFfdxpb1qxVXDKZV2sHtAYX1RrFTtRMPdbtB7ANsLk9Yak8AH4Sxom2z
         HKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421253; x=1760026053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAay7WQAYhXYn/E/OMo5YGGzkwYxNsk2ckJPOjY/KOo=;
        b=VLavrVuIqIlfBAqI49plbJ7c41kWgcDz58A904gd5jI1yeOmXL/mldbIDssTBXiPcS
         SmrZ/+P0D3rj6F4fEO5CAOQJkH5MMB1orKBuSyWt0zso7AWGJQ62Vk+iAwViyNAPcqaZ
         cJMwSsLuY8PDJQ3f6kA4zCOJMR99gJ2Hptqxek4uPTY9QzIpYf9q/uqcFy6GUr2bwnxT
         4C+/NMcW1LleJoHP8tXEppJFT2bSUl7LzHQ8U6pqTl8ZujlXrpM659dcNvJVepYE2T4+
         LNqfq9gTp9G9D/GcxWDySP+nr4qLRuOL8Hdbh3hTGiHxeSsMsSMG7ZsTU94b3VO2KqQm
         t/hw==
X-Gm-Message-State: AOJu0YxlfLbauiuPYRcGrqprelseI5lDJHEACOkCJ0+AMuYXU0bpLz70
	jPChAJuJr8+A7j1B/J5eCkTw29FIfXaicoWFcS24KgYCyq1r9cY4NUjLIO70QXOfCVOP7fg8UEI
	man47J4kCbyZ6ebZSgFQZBpdk+R1mU++usMse
X-Gm-Gg: ASbGncswrjK/yCaKyd6NHQO1pyMPcZ9Iql9PpOryEcrquYkKmp3az7HtxHlK8632O/Q
	ikahKLjnOYzEy5up3QFtTuXjIdMQUMbtDGGmUywLd7D+QWJHw/2+pQ7G6y0bdh9XKxA84Py4cfm
	I15zImGkiVETaZdnYCPu9qIpUo5q25qpHBv9/trlotm9yoXZH+mNVG1OOe1Nh6SubToJReSD+9V
	efd7JDhAXFfmdQJfiqaBAW1py2nlcIHJaZVhmBeEZmhkyjH0QSRPRdeSg==
X-Google-Smtp-Source: AGHT+IERzNpFaZziuSdiVraKx9qiUDpOWhbpa+c0xUoc4qg+XanlVuTEk/VM3NsIHb6scZQ4Bi+MK0Wl4ghjMIjPJEs=
X-Received: by 2002:a53:c646:0:b0:636:1985:56c0 with SMTP id
 956f58d0204a3-63b6ff8527emr7680152d50.39.1759421252972; Thu, 02 Oct 2025
 09:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759397353.git.paul.chaignon@gmail.com> <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
In-Reply-To: <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Oct 2025 09:07:22 -0700
X-Gm-Features: AS18NWD8_LizYPB6Kb1_OIKFBbiDZ1U-AJ-rj6W6EyR4PaWlrhm--zy4tl2eZgE
Message-ID: <CAMB2axP+gYUmD73RyOjGCCykAZWbu5aUcAN=emkbbYSw4mAJOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:07=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> This patch adds support for crafting non-linear skbs in BPF test runs
> for tc programs. The size of the linear area is given by ctx->data_end,
> with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> ctx->data_end are null, a linear skb is used.
>
> This is particularly useful to test support for non-linear skbs in large
> codebases such as Cilium. We've had multiple bugs in the past few years
> where we were missing calls to bpf_skb_pull_data(). This support in
> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> BPF tests.
>
> In addition to the selftests introduced later in the series, this patch
> was tested by setting enabling non-linear skbs for all tc selftests
> programs and checking test failures were expected.
>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 3425100b1e8c..e4f4b423646a 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb,=
 struct __sk_buff *__skb)
>         /* cb is allowed */
>
>         if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> +                          offsetof(struct __sk_buff, data_end)))
> +               return -EINVAL;
> +
> +       /* data_end is allowed, but not copied to skb */
> +
> +       if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end)=
,
>                            offsetof(struct __sk_buff, tstamp)))
>                 return -EINVAL;
>
> @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto =3D {
>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *k=
attr,
>                           union bpf_attr __user *uattr)
>  {
> +       u32 tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>         bool is_l2 =3D false, is_direct_pkt_access =3D false;
>         struct net *net =3D current->nsproxy->net_ns;
>         struct net_device *dev =3D net->loopback_dev;
> +       u32 headroom =3D NET_SKB_PAD + NET_IP_ALIGN;
> +       u32 linear_sz =3D kattr->test.data_size_in;
>         u32 size =3D kattr->test.data_size_in;
>         u32 repeat =3D kattr->test.repeat;
>         struct __sk_buff *ctx =3D NULL;
> @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>         if (IS_ERR(ctx))
>                 return PTR_ERR(ctx);
>
> -       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> -                            size, NET_SKB_PAD + NET_IP_ALIGN,
> -                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info=
)));
> +       if (ctx) {
> +               if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +               if (ctx->data_end)
> +                       linear_sz =3D max(ETH_HLEN, ctx->data_end);
> +       }
> +
> +       data =3D bpf_test_init(kattr, linear_sz, size, headroom, tailroom=
);
>         if (IS_ERR(data)) {
>                 ret =3D PTR_ERR(data);
>                 data =3D NULL;
> @@ -1044,10 +1060,47 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, =
const union bpf_attr *kattr,
>                 ret =3D -ENOMEM;
>                 goto out;
>         }
> +
>         skb->sk =3D sk;
>
>         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> -       __skb_put(skb, size);
> +       __skb_put(skb, linear_sz);
> +
> +       if (unlikely(kattr->test.data_size_in > linear_sz)) {
> +               void __user *data_in =3D u64_to_user_ptr(kattr->test.data=
_in);
> +               struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +
> +               size =3D linear_sz;
> +               while (size < kattr->test.data_size_in) {
> +                       struct page *page;
> +                       u32 data_len;
> +
> +                       if (sinfo->nr_frags =3D=3D MAX_SKB_FRAGS) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +
> +                       page =3D alloc_page(GFP_KERNEL);
> +                       if (!page) {
> +                               ret =3D -ENOMEM;
> +                               goto out;
> +                       }
> +
> +                       data_len =3D min_t(u32, kattr->test.data_size_in =
- size,
> +                                        PAGE_SIZE);
> +                       skb_fill_page_desc(skb, sinfo->nr_frags, page, 0,=
 data_len);
> +
> +                       if (copy_from_user(page_address(page), data_in + =
size,
> +                                          data_len)) {
> +                               ret =3D -EFAULT;
> +                               goto out;
> +                       }
> +                       skb->data_len +=3D data_len;
> +                       skb->truesize +=3D PAGE_SIZE;
> +                       skb->len +=3D data_len;
> +                       size +=3D data_len;
> +               }
> +       }
>
>         data =3D NULL; /* data released via kfree_skb */

It seems that it can still double free if we error out when building
fragments. Maybe data need to be set to NULL right after
slab_build_skb() succeeds.

>
> @@ -1130,9 +1183,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>         convert_skb_to___skb(skb, ctx);
>
>         size =3D skb->len;
> -       /* bpf program can never convert linear skb to non-linear */
> -       if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> +       if (skb_is_nonlinear(skb)) {
> +               /* bpf program can never convert linear skb to non-linear=
 */
> +               WARN_ON_ONCE(linear_sz =3D=3D size);
>                 size =3D skb_headlen(skb);
> +       }
>         ret =3D bpf_test_finish(kattr, uattr, skb->data, NULL, size, retv=
al,
>                               duration);
>         if (!ret)
> --
> 2.43.0
>

