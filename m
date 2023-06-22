Return-Path: <bpf+bounces-3216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C624D73AD4C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 01:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3861C20BDC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F423C7F;
	Thu, 22 Jun 2023 23:42:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C821085
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 23:42:58 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8432120
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:42:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51be840891dso1504810a12.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687477376; x=1690069376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaHkEXvatn4i245qfVlodeClVHZ8VkKbdURyRr9V664=;
        b=NStKDz+/0+jVGcmGqn7xdHeO8W69mGGKq9S/c6x5t1WC6E9URBdKd1shvdgWdtNeZ5
         /GmIouR4lGLRzaD3YCpPwAOvMWof01J8C1Av+Rc5NeXKwRd5d7aQ6hSZQ6pzGaA2clod
         5oFU+m40y0ROv9iBLSa1b/XcbSlSDl91y16nLtbJFvf/1vqWrg6ExoTc92zxAZPJ5R8A
         uaw+WqPACQZpmKVVEeJZ3tNc61eogvT8aIS4qDkdbCBEOpMXB0JZotpK6DZka+GiZMAd
         JH1YhroMSlx54IVCG48wGcnamaYmka2kFsUDICUcmGrtSYWRJe3BInCUh4mMJkekmCsK
         0PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687477376; x=1690069376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaHkEXvatn4i245qfVlodeClVHZ8VkKbdURyRr9V664=;
        b=YI1JuKFRUs5BO4leLry2u9IFY65Yr1yf7Pm9MsYeKCblu4CodSrvDzEaLB46z8UFTl
         H5a4oINrs6b3uaZtYcoL4jxMjTkzlEbaiGP6643YaZlBHVAyZw53+7HmkkZ+/Qo/c9Ay
         5AaUs6Edn3XX6htR4E+xsDKkiRE+y+KW/rr+VhUUuhUuPlSGotKfFbRdzqV4JmBB+2F4
         m/9S7pRwHicNVhjm3UF7x4E39yLkC2+TowWWbtMDdmqoAGsIlQt6damqu0wjLUfABDyj
         6hlY4fAmzd6Glx9CDGyH4aL3e1JPOMWCbqTfvhlfojKdTkk8EpzYlJq0DH/6s58dP58v
         SA5Q==
X-Gm-Message-State: AC+VfDyDi6qNCI9G+7t/L1ASl+czBPvp2iiHsqvTnG7ysjC+QXwrYDXe
	3aI6X/qCjhbELt982PXEaoYxJ/dIa4f57tVUjsU=
X-Google-Smtp-Source: ACHHUZ4tYOPB+FWiSVHPIIft85QO+AglRgVdsREP3lZm1J7Z04njB64OzudT7U5nJHTPOrJAFivjEcgWmNUSuDLXtTs=
X-Received: by 2002:aa7:cfc9:0:b0:51b:ee9a:8977 with SMTP id
 r9-20020aa7cfc9000000b0051bee9a8977mr901219edy.38.1687477375635; Thu, 22 Jun
 2023 16:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120012.3883-1-laoar.shao@gmail.com>
In-Reply-To: <20230621120012.3883-1-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jun 2023 16:42:44 -0700
Message-ID: <CAADnVQJizR0kMaQxKvs8tgvedPVExcHNFgDde28M7TgtzeEjkw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Fix an error in verifying a field in a union
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We are utilizing BPF LSM to monitor BPF operations within our container
> environment. When we add support for raw_tracepoint, it hits below
> error.
>
> ; (const void *)attr->raw_tracepoint.name);
> 27: (79) r3 =3D *(u64 *)(r2 +0)
> access beyond the end of member map_type (mend:4) in struct (anon) with o=
ff 0 size 8
>
> It can be reproduced with below BPF prog.
>
> SEC("lsm/bpf")
> int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int size)
> {
>         switch (cmd) {
>         case BPF_RAW_TRACEPOINT_OPEN:
>                 bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint.n=
ame);
>                 break;
>         default:
>                 break;
>         }
>         return 0;
> }
>
> The reason is that when accessing a field in a union, such as bpf_attr, i=
f
> the field is located within a nested struct that is not the first member =
of
> the union, it can result in incorrect field verification.
>
>   union bpf_attr {
>       struct {
>           __u32 map_type; <<<< Actually it will find that field.
>           __u32 key_size;
>           __u32 value_size;
>          ...
>       };
>       ...
>       struct {
>           __u64 name;    <<<< We want to verify this field.
>           __u32 prog_fd;
>       } raw_tracepoint;
>   };
>
> Considering the potential deep nesting levels, finding a perfect solution
> to address this issue has proven challenging. Therefore, I propose a
> solution where we simply skip the verification process if the field in
> question is located within a union.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/btf.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index bd2cac057928..79ee4506bba4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6129,7 +6129,7 @@ enum bpf_struct_walk_result {
>  static int btf_struct_walk(struct bpf_verifier_log *log, const struct bt=
f *btf,
>                            const struct btf_type *t, int off, int size,
>                            u32 *next_btf_id, enum bpf_type_flag *flag,
> -                          const char **field_name)
> +                          const char **field_name, bool *in_union)
>  {
>         u32 i, moff, mtrue_end, msize =3D 0, total_nelems =3D 0;
>         const struct btf_type *mtype, *elem_type =3D NULL;
> @@ -6188,6 +6188,8 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
>                 return -EACCES;
>         }
>
> +       if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNION && !in_union)
> +               *in_union =3D true;
>         for_each_member(i, t, member) {
>                 /* offset of the field in bytes */
>                 moff =3D __btf_member_bit_offset(t, member) / 8;
> @@ -6372,7 +6374,7 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
>                  * that also allows using an array of int as a scratch
>                  * space. e.g. skb->cb[].
>                  */
> -               if (off + size > mtrue_end) {
> +               if (off + size > mtrue_end && !in_union) {

Just allow it for (flag & PTR_UNTRUSTED).
We set it when we start walking BTF_KIND_UNION.
No need for extra bool.

