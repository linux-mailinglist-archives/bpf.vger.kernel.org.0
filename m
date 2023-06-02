Return-Path: <bpf+bounces-1749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A1720BCE
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B90281AEA
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A8C155;
	Fri,  2 Jun 2023 22:16:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F69C13B
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 22:16:29 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB71B7
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:16:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51478f6106cso3748507a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685744186; x=1688336186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JbDme89MMrqVDAm6zDY4tug6b52bL/LrpL3CHn+qjA=;
        b=V/TAaibd10Ye7FRUmXkZLT7WPg9Wenaer54Bb1p/6n7RiZSgl+ocoCdd/wg3EjxHfR
         xiZZu4QFKJiNhuuu0UtmxkGUXGfnwEdF+uMD69lqTgBJvVCH6utR/L/BHDcuzLn5vyTo
         WNsV4ZJyR0k1bzYSx1eEH831tH07dqqIIT9ypNVxfY5Jy1Uh3xI5PX/sCLD1oNQbuR2w
         UyMsdxR98rP3DzX4HcW00KqVirxqFYAPJg3PKLQsOy3obYhKdJDlJ0B7Ofrv30ieVfD+
         bWW3My+PTQkq36yPlZfn8X/aTK6osohPRSeQu44Ti3+2emuF2uBX2v7oChGRotf0pSkC
         FhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685744186; x=1688336186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JbDme89MMrqVDAm6zDY4tug6b52bL/LrpL3CHn+qjA=;
        b=RZ40CREVNoi5gpuk6pZT3T/V7K2DGwk7Nd6kf5qIM3yGByCfGTUUzpfQa1oRGmuwC2
         F4ZUkQHr3F7VWXKIAqX7SLloKuvHfgMHdRTvSG7+WvUczDQSVmsvUQiDbCdpLp+CfviV
         24CDo31Tn/O/2WcL90qPfL0xM2MPdPXHgLDyI8anRxn6GyRAJXiD6Br+4mU/YfmlIMrH
         tvoMEmmEwWYjJ8/gvfxb5cFkY5sQed04/cpTuQYvWCJe3IKVmF6Fw8+ooSazsVLG+a1S
         IjNw2ZZ7HPyCsaWWlwJybWB294/VfwXmzdFAJsscnoju4Wh0wwFciGcbWY+10WAqavit
         dWOA==
X-Gm-Message-State: AC+VfDybx5qoXw1XWxkGZZWkoXKfpHc0PIEtuCkRp1dFgH2A3Er6rqfa
	4h1Q8b3cV7KuLnokzhPeh8eC0ynVWhvZ8iIQMcw=
X-Google-Smtp-Source: ACHHUZ5HuG9RH3jLIbtzGKltFexFJPGk7gY+XpT24xEGTJBfuTfTAw+KrgXBsDSsTqrb5Lt5Rm/Mzs7YC9sBNLqAJjs=
X-Received: by 2002:a50:fb94:0:b0:515:4043:4771 with SMTP id
 e20-20020a50fb94000000b0051540434771mr2216768edq.42.1685744185895; Fri, 02
 Jun 2023 15:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-3-laoar.shao@gmail.com>
In-Reply-To: <20230602085239.91138-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 15:16:13 -0700
Message-ID: <CAEf4BzbJCCxj-0CCy_xsiJKk1Re_iXNGH95j9ChnOwSeeLUYEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpftool: Show probed function in
 kprobe_multi link info
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 1:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
> $ tools/bpf/bpftool/bpftool link show
> 1: kprobe_multi  prog 5
>         func_cnt 4  addrs            symbols
>                     ffffffffb4d465b0 schedule_timeout_interruptible
>                     ffffffffb4d465f0 schedule_timeout_killable
>                     ffffffffb4d46630 schedule_timeout_uninterruptible
>                     ffffffffb4d46670 schedule_timeout_idle
>         pids trace(8729)
>
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":1,"type":"kprobe_multi","prog_id":5,"func_cnt":4,"addrs":[{"addr":=
18446744072448402864,"symbol":"schedule_timeout_interruptible"},{"addr":184=
46744072448402928,"symbol":"schedule_timeout_killable"},{"addr":18446744072=
448402992,"symbol":"schedule_timeout_uninterruptible"},{"addr":184467440724=
48403056,"symbol":"schedule_timeout_idle"}],"pids":[{"pid":8729,"comm":"tra=
ce"}]}]


probably a good idea to also show whether it's retprobe or not?

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 94 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 2d78607..3b00c07 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -166,6 +166,57 @@ static int get_prog_info(int prog_id, struct bpf_pro=
g_info *info)
>         return err;
>  }
>
> +static int cmp_u64(const void *A, const void *B)
> +{
> +       const __u64 *a =3D A, *b =3D B;
> +
> +       return *a - *b;
> +}
> +
> +static void kprobe_multi_print_plain(__u64 addr, char *sym, __u32 indent=
)
> +{
> +       printf("\n\t%*s  %0*llx %s", indent, "", 16, addr, sym);
> +}
> +
> +static void kprobe_multi_print_json(__u64 addr, char *sym)
> +{
> +       jsonw_start_object(json_wtr);
> +       jsonw_uint_field(json_wtr, "addr", addr);
> +       jsonw_string_field(json_wtr, "symbol", sym);
> +       jsonw_end_object(json_wtr);
> +}
> +
> +static void kernel_syms_show(const __u64 *addrs, __u32 cnt, __u32 indent=
)
> +{
> +       char buff[256], sym[256];
> +       __u64 addr;
> +       int i =3D 0;
> +       FILE *fp;
> +
> +       fp =3D fopen("/proc/kallsyms", "r");
> +       if (!fp)
> +               return;
> +
> +       /* Each address is guaranteed to be unique. */
> +       qsort((void *)addrs, cnt, sizeof(__u64), cmp_u64);
> +       /* The addresses in /proc/kallsyms are already sorted. */
> +       while (fgets(buff, sizeof(buff), fp)) {
> +               if (sscanf(buff, "%llx %*c %s", &addr, sym) !=3D 2)
> +                       continue;
> +               /* The addr probed by kprobe_multi is always in
> +                * /proc/kallsyms, so we can ignore some edge cases.
> +                */
> +               if (addr !=3D addrs[i])
> +                       continue;
> +               if (indent)
> +                       kprobe_multi_print_plain(addr, sym, indent);
> +               else
> +                       kprobe_multi_print_json(addr, sym);
> +               i++;
> +       }
> +       fclose(fp);
> +}
> +
>  static int show_link_close_json(int fd, struct bpf_link_info *info)
>  {
>         struct bpf_prog_info prog_info;
> @@ -218,6 +269,17 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
>                 jsonw_uint_field(json_wtr, "map_id",
>                                  info->struct_ops.map_id);
>                 break;
> +       case BPF_LINK_TYPE_KPROBE_MULTI:
> +               const __u64 *addrs;
> +
> +               jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi=
.count);
> +               jsonw_name(json_wtr, "addrs");
> +               jsonw_start_array(json_wtr);
> +               addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.ad=
drs);
> +               if (info->kprobe_multi.count)
> +                       kernel_syms_show(addrs, info->kprobe_multi.count,=
 0);
> +               jsonw_end_array(json_wtr);
> +               break;
>         default:
>                 break;
>         }
> @@ -396,6 +458,20 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
>         case BPF_LINK_TYPE_NETFILTER:
>                 netfilter_dump_plain(info);
>                 break;
> +       case BPF_LINK_TYPE_KPROBE_MULTI:
> +               __u32 indent, cnt, i;
> +               const __u64 *addrs;
> +
> +               cnt =3D info->kprobe_multi.count;
> +               if (!cnt)
> +                       break;
> +               printf("\n\tfunc_cnt %d  %-16s %s", cnt, "addrs", "symbol=
s");
> +               for (i =3D 0; cnt; i++)
> +                       cnt /=3D 10;
> +               indent =3D strlen("func_cnt ") + i;
> +               addrs =3D (const __u64 *)u64_to_ptr(info->kprobe_multi.ad=
drs);
> +               kernel_syms_show(addrs, cnt, indent);
> +               break;
>         default:
>                 break;
>         }
> @@ -417,7 +493,9 @@ static int do_show_link(int fd)
>  {
>         struct bpf_link_info info;
>         __u32 len =3D sizeof(info);
> +       __u64 *addrs =3D NULL;
>         char buf[256];
> +       int count;
>         int err;
>
>         memset(&info, 0, sizeof(info));
> @@ -441,12 +519,28 @@ static int do_show_link(int fd)
>                 info.iter.target_name_len =3D sizeof(buf);
>                 goto again;
>         }
> +       if (info.type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI &&
> +           !info.kprobe_multi.addrs) {
> +               count =3D info.kprobe_multi.count;
> +               if (count) {
> +                       addrs =3D calloc(count, sizeof(__u64));
> +                       if (!addrs) {
> +                               p_err("mem alloc failed");
> +                               close(fd);
> +                               return -1;
> +                       }
> +                       info.kprobe_multi.addrs =3D (unsigned long)addrs;
> +                       goto again;
> +               }
> +       }
>
>         if (json_output)
>                 show_link_close_json(fd, &info);
>         else
>                 show_link_close_plain(fd, &info);
>
> +       if (addrs)
> +               free(addrs);
>         close(fd);
>         return 0;
>  }
> --
> 1.8.3.1
>

