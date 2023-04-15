Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA66E2FBA
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDOIbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOIbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 04:31:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63331FE7
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 01:31:19 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4324C3F202
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681547475;
        bh=Wx0/JegDs5ydht80NXH/UwxmxbYUu5hxKxJx5a7E6kw=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=t4hdIyeWrLjtWVsp1rPtxqeOz3lw5SSM2tDExtC3WAp9UPmNaJF54i5v+fC1zwH4L
         0f0OmFu+A/qSZa9xTCW2Xn+iCEUnCnMBK1oDA1SmLe9Il/6x/2vJSmOYJD1l5z6Ik2
         ksaSi55sG22TQXAZiEIoqXpy5lYffsivw6lkYip5Uw/jFotvZNpx75sQ/H81f+eDi+
         80PEeqX+dhJhFDQgVzn5eAQUlslwj69300ym8kKpdax2G7q2AYRsdtqCDULuFkknFs
         5YPGA5HdCO/59+h9ayVRU6FghH+PEQPl7Ox3KjWTofcqRRcViSiVAbeGJII3mvM+d5
         aI0REM7ht9LJA==
Received: by mail-ej1-f72.google.com with SMTP id f2-20020a170906084200b0094e971d803bso2836697ejd.7
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 01:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681547474; x=1684139474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0/JegDs5ydht80NXH/UwxmxbYUu5hxKxJx5a7E6kw=;
        b=kAbp5sSBBwxoPRgwWRzbEtQcs2tuRP7oNXOmxnga5PcOl9ZdZfGam0XR6UfvoqdAR+
         Atw8UemhX7acErMe1A78FrxPWaTRmu7olddGrnd/zv6A4qP321+f/Ja0PO6dmyPdpklP
         ypztkqzsLQRYzNYY5I3mdD9HFIL1TBLY54KvFMRZWEO8O4mbEQiOQalMlBciSnKbsoQ3
         fVvHAIJ0g5uKx3ZuGdEcs5DKMuv2OYoVbSVqomnoJPS24SHQcRL+Om8v4vYOXDGEkk7m
         tum2wOdVN3SvaYa+tmJh3aIgn+Ys++5tAj0UAl+QBReiNAwWKVuV05CLp6kzvVsfx2YK
         tuUg==
X-Gm-Message-State: AAQBX9dB29zk1wO5AgrDFE5Qy0cOB7BY20anOO0HT36frpqEcXqAMuW0
        KTW/+ylpbVMYj13y4D7wefULeO1KnpVKn7a8a6r11A7KE+tjgz4sA3QTItJtvJk/zhiEEkK7TT1
        EAmMQ+F96cam4MzhpLdRyfjFpmb6jGw==
X-Received: by 2002:a17:907:2d1f:b0:94f:322d:909d with SMTP id gs31-20020a1709072d1f00b0094f322d909dmr9554ejc.63.1681547474682;
        Sat, 15 Apr 2023 01:31:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bD5nX03JewNoORuQdFHtYzSIEKXUwgdDNHDz4qbxSX6RiDgl4Lw29zLgKKwShLulQpqTQmQQ==
X-Received: by 2002:a17:907:2d1f:b0:94f:322d:909d with SMTP id gs31-20020a1709072d1f00b0094f322d909dmr9518ejc.63.1681547474284;
        Sat, 15 Apr 2023 01:31:14 -0700 (PDT)
Received: from localhost (host-87-18-123-182.retail.telecomitalia.it. [87.18.123.182])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709064a4a00b0094a4e970508sm3491554ejv.57.2023.04.15.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 01:31:13 -0700 (PDT)
Date:   Sat, 15 Apr 2023 10:31:13 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
Message-ID: <ZDpg0YmXpZFlvmpM@righiandr-XPS-13-7390>
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
 <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390>
 <q5rj72tmwlpzx6qgkromem5t7q6xmen52aavfr65olnuv52f3z@wzs4p3xz3635>
 <ZDl/KFLy7wOBa2tj@righiandr-XPS-13-7390>
 <CAADnVQJFxoYqBisj4w_Mm35mf3gR6YTK0QvNjQfVSjfcQK33yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJFxoYqBisj4w_Mm35mf3gR6YTK0QvNjQfVSjfcQK33yw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 06:15:41PM -0700, Alexei Starovoitov wrote:
> On Fri, Apr 14, 2023 at 9:28 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Fri, Apr 14, 2023 at 06:15:38PM +0200, Ilya Leoshkevich wrote:
> > > On Fri, Apr 14, 2023 at 08:15:03AM +0200, Andrea Righi wrote:
> > > > On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Apr 12, 2023 at 2:59 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > >
> > > > > > Building bpf selftests with clang can trigger errors like the following:
> > > > > >
> > > > > >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > > > > > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
> > > > > >         s = &nlk->sk;
> > > > > >           ^ ~~~~~~~~
> > > > > > 1 error generated.
> > > > >
> > > > > I cannot reproduce this and BPF CI doesn't complain about it either.
> > > > > What kind of clang do you use?
> > > > > Some special version and build flags?
> > > >
> > > > I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special build
> > > > flag (unless Ubuntu enables some different default flags, but it
> > > > shouldn't be the case... I'll double check).
> > > >
> > > > -Andrea
> > >
> > > Hi,
> > >
> > > FWIW, I see similar errors when I don't use recent pahole.
> >
> > I'm using pahole v1.24.
> 
> I believe Ilya is correct.
> 
> struct sock___17 is likely coming from vmlinux.h
> Which means that there were errors due vmlinux build which
> caused multiple structs to be present in BTF
> and therefore bpftool generated such broken vmlinux.h
> 
> The BTF section in such vmlinux is likely much larger than normal.
> Let's get to the bottom of it instead of masking build error.
> 
> Please try pahole 1.25.

Yay! Success. Everything is working fine with pahole 1.25. Please ignore
my patch, the fix is to simply upgrade pahole.

Thanks!
-Andrea
