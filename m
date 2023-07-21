Return-Path: <bpf+bounces-5590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711375C12C
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A7B1C21601
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5FA14F66;
	Fri, 21 Jul 2023 08:18:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023614F60
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 08:18:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A4C6
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689927479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWAtfDt+4FFr8z2L0240XKTF6ityOHMPZsX6cXcmsiA=;
	b=WZpMWO4beRwM+SPbuB+tKbOC/vhyIC9v++ghRgWsSRlTCr77jmHfQloQxJzqfTvzaXJxgU
	GzSWg0yQfYkIA7UJqo2cmK724biq6lq89AULqZ4EtavDIZG2fz5NdpIW1BlMbS3DsAbqQI
	F9q/o6xdfXjnP+76IdDKzLMi5t6uwI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-yQAYrp0sMI6XjhndZoMrlQ-1; Fri, 21 Jul 2023 04:17:57 -0400
X-MC-Unique: yQAYrp0sMI6XjhndZoMrlQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3143b999f6eso901209f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927476; x=1690532276;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWAtfDt+4FFr8z2L0240XKTF6ityOHMPZsX6cXcmsiA=;
        b=O0kMa2YpoYtPXk3X1mfBUemH8WA/9xBCFXvNSDfmgz6KD9DV+wcFrkqUmrwp7tCCRf
         IelTzsR6SrOX/jlQOwLEt77PVwe6sEN2bcHBOc7Pc992PTY/XhD22ZXpd6iJhfWSf4Z5
         DVRsZv4FjzXNyT5lsQ3W/JBh3LCijtr4cVArOuFIlGAicFJYu6cWmpQFhnJ+uebRPYsQ
         5Krlh1NLNfh4t4EQrGcJeGx1sMij2TMw2yA8mvb9WKI3W1ldzsINr0j05LXoPFbpADb+
         KxjbKM21j3+AtnhXxkg2oz5xI0Gg7snlZbKS3o8ROlfSvLxvvLLnEitQFNZjMAs+MV5U
         bpXg==
X-Gm-Message-State: ABy/qLYAgsvAgXSkS+8lwKvcynQ0bzrwPCL8N+pNwRptepxMrEDKFCW5
	6R+UP6Ckl/SyWWY30GxCWSYD8QhpshNmf71ztEuWihaH+dKiX7ZK59dqG3o7aePbvNTTxe9He+h
	M69zejYTDflIJ
X-Received: by 2002:adf:e44b:0:b0:314:23b:dc56 with SMTP id t11-20020adfe44b000000b00314023bdc56mr932427wrm.71.1689927476491;
        Fri, 21 Jul 2023 01:17:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEdRURX7Fjh/lMcHTt/3ezRGKcsgd4gH+GjQ+oOshjaOTIibUtlYcUjT+ZyXHohXPiIFUBeg==
X-Received: by 2002:adf:e44b:0:b0:314:23b:dc56 with SMTP id t11-20020adfe44b000000b00314023bdc56mr932410wrm.71.1689927476191;
        Fri, 21 Jul 2023 01:17:56 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6046000000b003143b14848dsm3444226wrt.102.2023.07.21.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:17:55 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 16/20] rcu: Make RCU dynticks counter size
 configurable
In-Reply-To: <20230720163056.2564824-17-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-17-vschneid@redhat.com>
Date: Fri, 21 Jul 2023 09:17:53 +0100
Message-ID: <xhsmhjzutu18u.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/23 17:30, Valentin Schneider wrote:
> index bdd7eadb33d8f..1ff2aab24e964 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -332,4 +332,37 @@ config RCU_DOUBLE_CHECK_CB_TIME
>         Say Y here if you need tighter callback-limit enforcement.
>         Say N here if you are unsure.
>
> +config RCU_DYNTICKS_RANGE_BEGIN
> +	int
> +	depends on !RCU_EXPERT
> +	default 31 if !CONTEXT_TRACKING_WORK

You'll note that this should be 30 really, because the lower *2* bits are
taken by the context state (CONTEXT_GUEST has a value of 3).

This highlights the fragile part of this: the Kconfig values are hardcoded,
but they depend on CT_STATE_SIZE, CONTEXT_MASK and CONTEXT_WORK_MAX. The
static_assert() will at least capture any misconfiguration, but having that
enforced by the actual Kconfig ranges would be less awkward.

Do we currently have a way of e.g. making a Kconfig file depend on and use
values generated by a C header?


