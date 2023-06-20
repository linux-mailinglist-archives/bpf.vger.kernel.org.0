Return-Path: <bpf+bounces-2926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37262737084
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13D22813A2
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC55174F0;
	Tue, 20 Jun 2023 15:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF7174DD;
	Tue, 20 Jun 2023 15:32:47 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49C186;
	Tue, 20 Jun 2023 08:32:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5186a157b85so6726562a12.0;
        Tue, 20 Jun 2023 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275165; x=1689867165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0jVFIWxWqZ/TuBplqDvmEEANKo26b83Dz5MygWHhzo=;
        b=R2BhcgahF4eA1vnlN0qyJmASSGyaKyq8k8oOrUAtCf6A4nOmgevBEhPzEV8rIbjTgF
         yXzVElUQYcMdeYQTQkO+X2Y+9ZuwgkppnVdZSXyRsEkPbs6x/ssnctoQke0QTIMErPf3
         qLgAPk3+Vpo3W0G2QiGZq35LggwDfRrpFYUUYGCVB1g7szVQ79eBlKEygcj7p7OVjxQf
         pa51oJokqPD+3D2MoPj8cm17qxZzYmsGb5TOKjwNPuJs0U4g/8S2QCH5/u+vSkwhFWvm
         3m8n5V/yFyRQTrN52yzRlNSqLm1w2gZ7QUzER3KDhhogdRbdvNc25JV4yGkEnTVq2UW0
         ShAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275165; x=1689867165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0jVFIWxWqZ/TuBplqDvmEEANKo26b83Dz5MygWHhzo=;
        b=XS2HZDXys8QaRBHr+MImx1H5MzU9FyVaONq+gPKBJvkypyXU/vBxA0/GeRIr2FnRCL
         W7SWmbfRZJreWd71BT5PHLOQp9B3W7uEW6ZthYgscyaifrV9dSYqf2yGToWc0q5afq4W
         w+2/oirKs2srAlLQcj2n7YRTTSk/r7d0mWsshc76/H8dGrSVIcjIp+DWteirPnsE+l1Z
         EH8xXhpamEgG9BcKPb2NmmJJZnQtwBBU1gjm9uu287ERcnYe+mXuAUX5p63VWvuIHesl
         xVcC1Y17+bneyPS2ewkN4e0xkVlQ1XUvhc4NFl7C/pbP9+T/PWWcHhlwFxLmenRmJPLu
         0I6Q==
X-Gm-Message-State: AC+VfDwp0VBv8JoND5a7qw1QUc1/XgKqldfKBeZgmw2CaobiuBO/mbdl
	Wr48MLFVqbZaBJK9bSWgd6scnfvJgltCAHsNxac=
X-Google-Smtp-Source: ACHHUZ5ux98lA0dfOqVXfQP0ndlYyBoHuqHpCIjpPqNu3qgP8TLa7JJDdMIHBmrGJ6oD7j3SfcbrFl7+8TyeQPspzGA=
X-Received: by 2002:aa7:cf16:0:b0:51a:40ca:d081 with SMTP id
 a22-20020aa7cf16000000b0051a40cad081mr7305340edy.27.1687275164525; Tue, 20
 Jun 2023 08:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-7-rppt@kernel.org>
 <87jzw0qu3s.ffs@tglx> <20230618231431.4aj3k5ujye22sqai@moria.home.lan>
 <87h6r4qo1d.ffs@tglx> <20230620105104.60cb64d8@gandalf.local.home>
In-Reply-To: <20230620105104.60cb64d8@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jun 2023 08:32:33 -0700
Message-ID: <CAADnVQK_dWhPxdjs4HuAXWBTeVAf01er15dZU8tC+d=g6QCPXw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] mm/execmem: introduce execmem_data_alloc()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Song Liu <song@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Will Deacon <will@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, loongarch@lists.linux.dev, 
	Network Development <netdev@vger.kernel.org>, sparclinux@vger.kernel.org, 
	X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 7:51=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 19 Jun 2023 02:43:58 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > Now you might argue that it _is_ a "hotpath" due to the BPF usage, but
> > then even more so as any intermediate wrapper which converts from one
> > data representation to another data representation is not going to
> > increase performance, right?
>
> Just as a side note. BPF can not attach its return calling code to
> functions that have more than 6 parameters (3 on 32 bit x86), because of
> the way BPF return path trampoline works. It is a requirement that all
> parameters live in registers, and none on the stack.

It's actually 7 and that restriction is being lifted.
The patch set to attach to <=3D 12 is being discussed.

