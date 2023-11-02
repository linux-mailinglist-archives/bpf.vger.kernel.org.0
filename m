Return-Path: <bpf+bounces-13927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F57DEE87
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82F41C20F19
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0479EF;
	Thu,  2 Nov 2023 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a03a0BA0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40779C2
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:58:17 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8BF181;
	Thu,  2 Nov 2023 01:58:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1091766a12.0;
        Thu, 02 Nov 2023 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915494; x=1699520294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XdpLtaMqlycG6dpZKoLJeqo+WNCOF7ofJ2N+iMTRVD0=;
        b=a03a0BA0k+fWvexnChoFSNpKViajpSN9GPV3yvwruvvgOtppGbU2J2fRGD+4tula5L
         vH0juGf8AgFZ2gF6kCNR58yxB1DIQdtVGo9aASsBHq5c3O+6tm4ra5J+wK5WkkFFEz4s
         GdQuF/mo/loQitpPeMSJ9lPzQRxWoXWZZEg3eJMsXqU80+Eh1e9ksE4HrGfEkne4K5zl
         C3i5+s5+hnlQTkdGSJaB6rCt0q5crfr2CgVYpb8ioLuD9lWeakb1cer34DKAjnPcD6lJ
         k7kJsfjDwhuoOvqNKQdlwdzVwESnQykq6Ofa8xKLyeMV4YYLg2uGXILIvILXMwZZtZ8O
         3jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915494; x=1699520294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdpLtaMqlycG6dpZKoLJeqo+WNCOF7ofJ2N+iMTRVD0=;
        b=DkO8cHjPHCiYer5/JB69CdvV8HriOuNO16Vnpw/zUhxMBFSAgDlUxjdQ8IrI047DCx
         r24n5OWeCWF7TdUTs3n3/9efHAmYYg0QjRNweKAiG5U409mv7qims0BzQUzNpoajl46Q
         4GWQcOhcse0Io0FZovLGLemYj/G8LiBMb4yXoAYMgstjtQc5sfFlLC1503dln/iJxnvu
         /YVlFomZmoXZVaUI9mlaRcTFCQSvg0HqWHvEhVRlc63USuHz7z/XoYUoevKF+HVWiOS1
         1LqgtZD4mDKXh6s4v8djmMnIqhAjabzwbds8lovVHpsSeZAvwIvD28z9O2O/0FlFpnHn
         xZFQ==
X-Gm-Message-State: AOJu0Yz7MIA9BlnPNXekg5elIuTKT6csysQepif3qD4ngn7rqnj3XQxV
	7DvVJ9bp2/TX5e7th4ULkQFd682WB07yNw==
X-Google-Smtp-Source: AGHT+IGB6HqMMJLw26kkHPDNuOijtWxrcNXkMMGvtBcRKVnG1yLhv5wWHpvVD3g7SEBh0MR2RKEzSg==
X-Received: by 2002:a17:906:f0c9:b0:9b8:b683:5854 with SMTP id dk9-20020a170906f0c900b009b8b6835854mr3206142ejb.61.1698915493603;
        Thu, 02 Nov 2023 01:58:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id jw24-20020a17090776b800b009ad75d318ffsm881696ejc.17.2023.11.02.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:58:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 09:58:11 +0100
To: KP Singh <kpsingh@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org,
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, renauld@google.com, pabeni@redhat.com
Subject: Re: [PATCH v6 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZUNko7AU7hDTk7LU@krava>
References: <20231006204701.549230-1-kpsingh@kernel.org>
 <20231006204701.549230-5-kpsingh@kernel.org>
 <ZSPRrtkKtf9WyBOy@krava>
 <CACYkzJ5PKECadW+B9ybJUidDb6SVb6L4A2xWqwh6ybkhfZ+eag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ5PKECadW+B9ybJUidDb6SVb6L4A2xWqwh6ybkhfZ+eag@mail.gmail.com>

On Thu, Nov 02, 2023 at 01:46:14AM +0100, KP Singh wrote:
> On Mon, Oct 9, 2023 at 12:11 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 10:47:00PM +0200, KP Singh wrote:
> > > BPF LSM hooks have side-effects (even when a default value is returned),
> > > as some hooks end up behaving differently due to the very presence of
> > > the hook.
> > >
> > > The static keys guarding the BPF LSM hooks are disabled by default and
> > > enabled only when a BPF program is attached implementing the hook
> > > logic. This avoids the issue of the side-effects and also the minor
> > > overhead associated with the empty callback.
> > >
> > > security_file_ioctl:
> > >    0xffffffff818f0e30 <+0>:   endbr64
> > >    0xffffffff818f0e34 <+4>:   nopl   0x0(%rax,%rax,1)
> > >    0xffffffff818f0e39 <+9>:   push   %rbp
> > >    0xffffffff818f0e3a <+10>:  push   %r14
> > >    0xffffffff818f0e3c <+12>:  push   %rbx
> > >    0xffffffff818f0e3d <+13>:  mov    %rdx,%rbx
> > >    0xffffffff818f0e40 <+16>:  mov    %esi,%ebp
> > >    0xffffffff818f0e42 <+18>:  mov    %rdi,%r14
> > >    0xffffffff818f0e45 <+21>:  jmp    0xffffffff818f0e57 <security_file_ioctl+39>
> > >                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > >    Static key enabled for SELinux
> > >
> > >    0xffffffff818f0e47 <+23>:  xchg   %ax,%ax
> > >                               ^^^^^^^^^^^^^^
> > >
> > >    Static key disabled for BPF. This gets patched when a BPF LSM program
> > >    is attached
> > >
> > >    0xffffffff818f0e49 <+25>:  xor    %eax,%eax
> > >    0xffffffff818f0e4b <+27>:  xchg   %ax,%ax
> > >    0xffffffff818f0e4d <+29>:  pop    %rbx
> > >    0xffffffff818f0e4e <+30>:  pop    %r14
> > >    0xffffffff818f0e50 <+32>:  pop    %rbp
> > >    0xffffffff818f0e51 <+33>:  cs jmp 0xffffffff82c00000 <__x86_return_thunk>
> > >    0xffffffff818f0e57 <+39>:  endbr64
> > >    0xffffffff818f0e5b <+43>:  mov    %r14,%rdi
> > >    0xffffffff818f0e5e <+46>:  mov    %ebp,%esi
> > >    0xffffffff818f0e60 <+48>:  mov    %rbx,%rdx
> > >    0xffffffff818f0e63 <+51>:  call   0xffffffff819033c0 <selinux_file_ioctl>
> > >    0xffffffff818f0e68 <+56>:  test   %eax,%eax
> > >    0xffffffff818f0e6a <+58>:  jne    0xffffffff818f0e4d <security_file_ioctl+29>
> > >    0xffffffff818f0e6c <+60>:  jmp    0xffffffff818f0e47 <security_file_ioctl+23>
> > >    0xffffffff818f0e6e <+62>:  endbr64
> > >    0xffffffff818f0e72 <+66>:  mov    %r14,%rdi
> > >    0xffffffff818f0e75 <+69>:  mov    %ebp,%esi
> > >    0xffffffff818f0e77 <+71>:  mov    %rbx,%rdx
> > >    0xffffffff818f0e7a <+74>:  call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
> > >    0xffffffff818f0e7f <+79>:  test   %eax,%eax
> > >    0xffffffff818f0e81 <+81>:  jne    0xffffffff818f0e4d <security_file_ioctl+29>
> > >    0xffffffff818f0e83 <+83>:  jmp    0xffffffff818f0e49 <security_file_ioctl+25>
> > >    0xffffffff818f0e85 <+85>:  endbr64
> > >    0xffffffff818f0e89 <+89>:  mov    %r14,%rdi
> > >    0xffffffff818f0e8c <+92>:  mov    %ebp,%esi
> > >    0xffffffff818f0e8e <+94>:  mov    %rbx,%rdx
> > >    0xffffffff818f0e91 <+97>:  pop    %rbx
> > >    0xffffffff818f0e92 <+98>:  pop    %r14
> > >    0xffffffff818f0e94 <+100>: pop    %rbp
> > >    0xffffffff818f0e95 <+101>: ret
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Acked-by: Song Liu <song@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> >
> > small nit, but looks good
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > jirka
> >
> >
> > > ---
> > >  include/linux/bpf_lsm.h   |  5 +++++
> > >  include/linux/lsm_hooks.h | 13 ++++++++++++-
> > >  kernel/bpf/trampoline.c   | 24 ++++++++++++++++++++++++
> > >  security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
> > >  security/security.c       |  3 ++-
> > >  5 files changed, 67 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > index 1de7ece5d36d..5bbc31ac948c 100644
> > > --- a/include/linux/bpf_lsm.h
> > > +++ b/include/linux/bpf_lsm.h
> > > @@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > >
> > >  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> > >  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
> > > +void bpf_lsm_toggle_hook(void *addr, bool value);
> >
> > nit, this could be static, unless there are future plans ;-)
> 
> Actually, this is called from trampoline.c and cannot be static.

ah you're right, I missed that

jirka

