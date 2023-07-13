Return-Path: <bpf+bounces-4889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110375157B
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3130B1C210E3
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476F39C;
	Thu, 13 Jul 2023 00:44:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2977C;
	Thu, 13 Jul 2023 00:44:05 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79401BFB;
	Wed, 12 Jul 2023 17:44:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso870241fa.1;
        Wed, 12 Jul 2023 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689209042; x=1691801042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsR7IIVR2C+r7VaTstdlodEeJE6UeuUCvZM4AYitVX4=;
        b=hiPaVIfC+3Ijf+FJf8AudDGt8nmkFp5h80+Iz61I7MQas53BRygqwVPqfAnBOsuP24
         ckX4RjiiTus29/wG0c26hZBJBpbr4y8InppBLftwSlXRyZsrRskiVJRYsmbrD56HGD1G
         z3Hx2nUf8cPAF8+/kCPg+l+Mc6peqiqblpduM9zeBPL5a20h9oJkUZYElP1TN/6K5yYX
         QEeRnYTrZaCM5Af55e5bok2MDViBxVK5LJC7qc/xZPz28wc4riAcGon+6lCqapp9yuBD
         1atuvtoq6xiYLgumEJ9EYRfIksY31OeutQE1yLt7GjtBEp7PD5py0k9xZcZ/4sMsyTnn
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689209042; x=1691801042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsR7IIVR2C+r7VaTstdlodEeJE6UeuUCvZM4AYitVX4=;
        b=DInnk6ng2EatXf5BM1+3ULKlCy2kGcmnbhMtV61osA+MfdcwybGmTtoOcaHCMeTWSA
         42W/8lw07hob2YsYu+Vc3QfXPRfwN/V0xjafk495KrYsuc6IypvEOnGjXkKvAQ5VMC8T
         Hqz0EcQZToRLqxH4oM2sJzwTY8nERB5eJePns/gMng2CFj7IUPelIeYJaxAeIZoC5auq
         W0dF1zqwSt1jcZaRDB579nJx2fMyTxikaHq6g4lWa7PK0KfUfqly0r3g/WC7cxkLlp/D
         340r0jvgcxgKk580zspPwXyDBsXrGg5Va1sA6Xjre/Qi2MvmWxV/QStTlXS+HXbvRWmM
         SlTQ==
X-Gm-Message-State: ABy/qLaQr2rfJAQ0ODnKt3asH916bGFSRev6uw+oK2hPslrl0V073514
	w+ipk0M0FyDIycdSJXRuWwx1eMpjc9ueDE0OgSU=
X-Google-Smtp-Source: APBJJlH0MRY54EOAY03Y3tw1DrlYus79JqEZSLdNj2WGsj/wszKEAp+eXKZyyX3ygU7iO6wf1yA5M+y+wZVnXXQjQYo=
X-Received: by 2002:a2e:95c4:0:b0:2ac:82c1:5a3d with SMTP id
 y4-20020a2e95c4000000b002ac82c15a3dmr17882748ljh.23.1689209041673; Wed, 12
 Jul 2023 17:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689203090.git.dxu@dxuuu.xyz> <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
In-Reply-To: <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 17:43:49 -0700
Message-ID: <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Florian Westphal <fw@strlen.de>, 
	"David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> +       case NFPROTO_IPV6:
> +               rcu_read_lock();
> +               v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> +               if (!v6_hook) {
> +                       rcu_read_unlock();
> +                       err =3D request_module("nf_defrag_ipv6");
> +                       if (err)
> +                               return err < 0 ? err : -EINVAL;
> +
> +                       rcu_read_lock();
> +                       v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> +                       if (!v6_hook) {
> +                               WARN_ONCE(1, "nf_defrag_ipv6_hooks bad re=
gistration");
> +                               err =3D -ENOENT;
> +                               goto out_v6;
> +                       }
> +               }
> +
> +               err =3D v6_hook->enable(link->net);

I was about to apply, but luckily caught this issue in my local test:

[   18.462448] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:283
[   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
2042, name: test_progs
[   18.463927] preempt_count: 0, expected: 0
[   18.464249] RCU nest depth: 1, expected: 0
[   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
O       6.4.0-04319-g6f6ec4fa00dc #4896
[   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   18.466531] Call Trace:
[   18.466767]  <TASK>
[   18.466975]  dump_stack_lvl+0x32/0x40
[   18.467325]  __might_resched+0x129/0x180
[   18.467691]  mutex_lock+0x1a/0x40
[   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
[   18.468467]  bpf_nf_link_attach+0x141/0x300
[   18.468856]  __sys_bpf+0x133e/0x26d0

You cannot call mutex under rcu_read_lock.

Please make sure you have all kernel debug flags on in your testing.

