Return-Path: <bpf+bounces-70342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B710FBB7FF7
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C33919C3969
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF401F78E6;
	Fri,  3 Oct 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0zaJETA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC929405
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521020; cv=none; b=JMhBp1JYPYQMjV104bqph6OFX7DtvJ6KiNgRgeQWTMV42ARhp8tu++C74dYovXr2r3HSGJlploMf3S5Rozwk5glS0+0lrkqN8M7bvLIAv5vooG2fStmhV5PZGaNvqH0ZcbqkxxCa++f7JoLMbIUyoe8FMNI3sLJqREScw89eHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521020; c=relaxed/simple;
	bh=F2/zpcumbxfQWk+dJrm6jmbp0kf01nVj6mwaZtdLttg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIH1CK6z4qtJUw/8Ijfqqx+BUVR8OKuxzV1LvfbfYoXmSXi3brTJdAv2zL/wElRCMZo8PemMSvEnu6Rb+QFVRGDWqwxsqBRRyI1nGoxu3YGKsUfM8WVOaT0losvgrE32in0eEkqT7tIMbLHWnndqVgvpF/G4HKmk1mbZyAxdZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0zaJETA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af743c232so2331927b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521019; x=1760125819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMHlD9C9SgRAsMoVFhmTUDlSX0aOhTGIFPHs63VbijM=;
        b=R0zaJETAnbcphoJ34Sy6p5u2Z9NwXeZsTd85lcWjDxWtwjnT8mnf6dme0dUQo3xN2c
         b9qgZVedIYnyLpi7EJhMKEpKRbN3PRqBY1DP0B/wXbG6t7d7LiOYelyxj1udCaJ4I96v
         bkd6Ro1WHk/ymDK2+27jkVU+i6ojQ3FrjUJCeV71MOF6EYUReUoMTHhbITkK8R4ciPqj
         mOnvnbc6Z+OrCwJUN66oWhyC4tGBPcH0yy7Mo6U2eX8G43vPbMzA9owi7rlJz749NLOE
         hY/p1XreHzmV1aOFCAIYmtHtkIDWTb+uKrRSl7SlKyEqYpmdXWUnECVqiDFaIxZVI21b
         UKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521019; x=1760125819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMHlD9C9SgRAsMoVFhmTUDlSX0aOhTGIFPHs63VbijM=;
        b=E5q63SC8fPDb2ARflJxjWcqNHIFCwCnkKT5T62p1OnfovQwF72Ix9zGOhtDfkDcgGb
         QQcp2hefx2CoYJ1jZR9c9zPDFSJGzhfrfC9l+VlKQOBQ73po4MYNB6fwLyR67hSt0oFp
         GLGSZexy7YEFwL9EvfMSljG4JGbx3/yqOJC6UgVJw173OaFHHDGit4VZMUzhE9xAMBVT
         ZE6idSZkID8WQt7kxL2oyiI+tnfCgD3RTDitLXkjUjJa9ZqKnxcIrgwwYA5yZtwGcQxM
         BLdkXvvnxUbr1H8gtbS/E2Rwz8yFQIJADqVciwKmcTVheg+OFzUxJcsBC08MADJ7lAPs
         s9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVbleDjorYKPN34+cAKt9Yk1Dt8RxfI6JoR7OxS22m3Vgyc6ItAIfHyse6P/9tP3yBJeNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUiDi6u/jpgooVQT2MiVcs73aDytjnQKrDqwvv2IkELPRDRF/
	zBHm9si8HJ3NbRvReWUttEwOXZsnaquGIM3sAHLpdKpTskCvzJG2REmp
X-Gm-Gg: ASbGncsKmdpbUJuFhbK5uglIWii9uQpSFwnuwqKCjFGd71QW8q2wGFQBq8nkO/WHCpf
	puIbjXZzKT4xFY/gvmHpFtFLF9EI9qY1WqtS6lgSZh5PLrBDpU3DRNF+dp0R1nuaCLs7MYdIhwX
	08pxWDKfyavYfLpmCVoc1MEK6WvSPXyWZRIekGw7SPxP/y06KOK1nY+jqfy+jmEs2Ve5U/OIJq2
	bYuH2YRfmrw86BC1aL8MPA1ZOdNwZFNbcuuK5/VBxVhv0/dLyhE4ggZLV/JCmzI81dWqoqdvtqT
	Hk5Hddd3mb2VvGHVVlelhxU5SARMhDax0yqZqODCRU9Ys4MRRbG55kcJDvl0+oUCMasH6F+WFck
	HYFEopcig69rug3TSuashsL0rdZ0h7oERVfw1i/VsbVKOv6QBjLwj6EcLeAJVAiN8eJqI3DCEZn
	MMuscE2K4=
X-Google-Smtp-Source: AGHT+IH2BsVufEAm8X1OEmZXnjbV1+1k9Nvvbm3AyG1hVsjWi/gNus0PJlBHmreUrTE1FD3DufieqA==
X-Received: by 2002:a05:6a00:2eaa:b0:782:2f62:7059 with SMTP id d2e1a72fcca58-78c98cc35dcmr5113316b3a.22.1759521018533;
        Fri, 03 Oct 2025 12:50:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02076b09sm5652432b3a.79.2025.10.03.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:50:18 -0700 (PDT)
Message-ID: <4dee3cab07a35a04cc0fe1e90d45d2f2bcc05533.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 12:50:17 -0700
In-Reply-To: <ad9f22c83c1585d521df4160dd71af6b06df411e.camel@gmail.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
		 <6b2b44ddbec88ae4690b4eae33b712642b73db4c.camel@gmail.com>
		 <f3fd1043-6696-454d-bafd-9d1a84a937c5@gmail.com>
	 <ad9f22c83c1585d521df4160dd71af6b06df411e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 12:33 -0700, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 20:17 +0100, Mykyta Yatsenko wrote:
> > On 10/1/25 19:50, Eduard Zingerman wrote:
> > > On Wed, 2025-10-01 at 14:22 +0100, Mykyta Yatsenko wrote:
> > > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > > >
> > > > Move bpf_wq map-field validation into the common helper by adding a
> > > > BPF_WORKQUEUE case that maps to record->wq_off, and switch
> > > > process_wq_func() to use it instead of doing its own offset math.
> > > >
> > > > This de-duplicates logic with other internal structs (task_work, ti=
mer),
> > > > keeps error reporting consistent, and makes future changes to the l=
ayout
> > > > handling centralized.
> > > >
> > > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > > ---
> > > Note to reviewers: technically, this makes the check stricter,
> > > but no new correct BPF programs would be rejected.
> > > The cases that are checked by check_map_field_pointer,
> > > but which were not checked before this patch:
> > > - reg value is a constant
> > > - corresponding map has BTF
> > > - map record has BPF_WORKQUEUE field
> > >
> > > Not sure if ignoring one of these checks could lead to invalid memory
> > > access at runtime. I'd add fixes tag (and maybe a test), so that this
> > > commit could be grabbed for backporing:
> > >
> > > Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [...]
> > I tried to trigger some of these error conditions:
> > - map record has no bpf_wq: this errors out earlier: arg#%d doesn't
> > point to a map value
> > - corresponding map has no BTF: I think to create a map without BTF
> > I need an older libbpf version, not 100% sure how to do this
>
> BPF programs can be defined w/o libbpf.
> Here is a recent example:
> https://lore.kernel.org/bpf/20250930125111.1269861-1-a.s.protopopov@gmail=
.com/T/#m055919e0dd8ca15af3749bae6f9cbd2b13e4945f
> test cases there define a short program and pass a map w/o BTF to it.
>
> > - reg value is not constant - this one I don't know how to trigger.
> > Given all this, let's keep this simple and not add fixes tag, it does
> > not look like we are
> > actually fixing anything.
>
>  static int process_wq_func(struct bpf_verifier_env *env, int regno,
>                             struct bpf_kfunc_call_arg_meta *meta)
>  {
>          struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[reg=
no];
>          struct bpf_map *map =3D reg->map_ptr;
>          u64 val =3D reg->var_off.value;
>
>          if (map->record->wq_off !=3D val + reg->off) {
> 	     ^^^^^^^^^^^            ^^^^^^^^^^^^^^
> 	     |                      reg->off is 0, but 'val' is under attacker c=
ontrol,
> 	     |                      all is necessary is to conjure a tnum with k=
nown bits
> 	     |                      corresponding to wq_off value.
> 	     |
> 	  This can be NULL, so there is a potential null pointer dereference
>
>                  verbose(private_data: env, fmt: "off %lld doesn't point =
to 'struct bpf_wq' that is at %d\n",
>                          val + reg->off, map->record->wq_off);
>                  return -EINVAL;
>          }
>          meta->map.uid =3D reg->map_uid;
>          meta->map.ptr =3D map;
>          return 0;
>  }

The program below is accepted by verifier but is clearly wrong.
In this particular case the 'unknown' has 0 known bits,
but it so happens that wq offset is 0.

> it does not look like we are actually fixing anything.

We actually do.

---

diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftes=
ts/bpf/progs/wq.c
index 2f1ba08c293e..ed23ae239a1d 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -50,6 +50,17 @@ struct {
        __type(value, struct elem);
 } lru SEC(".maps");

+struct hmap_elem2 {
+       struct bpf_wq work;
+};
+
+struct {
+       __uint(type, BPF_MAP_TYPE_HASH);
+       __uint(max_entries, 1);
+       __type(key, int);
+       __type(value, struct hmap_elem2);
+} hmap2 SEC(".maps");
+
 __u32 ok;
 __u32 ok_sleepable;

@@ -187,3 +198,29 @@ long test_call_lru_sleepable(void *ctx)

        return test_elem_callback(&lru, &key, wq_callback);
 }
+
+SEC("tc")
+long test_bad_wq_off(void *ctx)
+{
+       struct hmap_elem2 *val;
+       struct bpf_wq *wq;
+       int key =3D 42;
+       u64 unknown;
+
+       val =3D bpf_map_lookup_elem(&hmap2, &key);
+       if (!val)
+               return -2;
+
+       unknown =3D bpf_get_prandom_u32();
+       wq =3D &val->work + unknown;
+       if (bpf_wq_init(wq, &hmap2, 0) !=3D 0)
+               return -3;
+
+       if (bpf_wq_set_callback(wq, wq_callback, 0))
+               return -4;
+
+       if (bpf_wq_start(wq, 0))
+               return -5;
+
+       return 0;
+}

