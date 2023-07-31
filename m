Return-Path: <bpf+bounces-6435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DC76948E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A1A1C20865
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95331800A;
	Mon, 31 Jul 2023 11:19:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AD8BF0
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 11:19:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E54E53
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690802348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liRJKw+opNrXfUwr+Bq4QbRM7UJXeuw3tZj+4BJUEBU=;
	b=SHuY2zU4BUpamVxGw/r7pnJuyKm8LyP1WTnrkDe+P30+qsHN8DQDvknKa59Aew3t9Sj7FU
	QWSk40s3e9SwlK82ygQLfy5Pzp/pheJpMfEdxEBay0/KjTy/q9U2KBb/bcC4oRPeQCrm8O
	M9hCORDcLWDs+iCWCziIEjizFe+MS1I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-rY4XJBW6PwutfJ0_tEJFLA-1; Mon, 31 Jul 2023 07:19:07 -0400
X-MC-Unique: rY4XJBW6PwutfJ0_tEJFLA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76843c4b0f3so350629885a.2
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 04:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802346; x=1691407146;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liRJKw+opNrXfUwr+Bq4QbRM7UJXeuw3tZj+4BJUEBU=;
        b=jT3HvY4H49CTJetDmFqjhl06tV6NUlcVcg7d/piGJu+FIuxDkF32wQRadFfr/bdCbJ
         /PsekY54DqoOEWSfOGuH1vYIi//HLkmukioCW37FTVf6YheE6SB+9mB6VQ4sxv5lKytH
         q3/+65MUGB/HMNM25GxN/gArrWKtDHJsL/9ty1jURj/+0+MOhxcqONfOcYDYG+8rTv/s
         tcA+dhujO2SfX/mPDObUq//OLczlyY/xyPsXPITWvKR9GJKYP6GjQ5HhDC6jnwIqoiX5
         35PWVcEPmTyhWpGPbsuVdhK08Z7RIn46BwhcIg1PFkbqL5gZqbEJDS4j/+M8yKz113dy
         Pokw==
X-Gm-Message-State: ABy/qLYZsGZxz5hvhaPpR3xQtIXkqdzK2G0eLc/NQCKFrczu39G/C3uI
	c6qt4YZUmfGBThxsbQAx9W8Io/H1qZGGtj47jOWicb/ZM6xtB6Kn8QrRa09t1QXDHspZFEio7J0
	dTi0/7It3UywG
X-Received: by 2002:a05:620a:4083:b0:766:68cd:d9dc with SMTP id f3-20020a05620a408300b0076668cdd9dcmr8634457qko.19.1690802346566;
        Mon, 31 Jul 2023 04:19:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxRoj22fts1ZRiVdo7BaEAZi0l1tMUruIOv4Nb34gy9lu7KljXIlDPd8x8zhbGrKa5lC+fNA==
X-Received: by 2002:a05:620a:4083:b0:766:68cd:d9dc with SMTP id f3-20020a05620a408300b0076668cdd9dcmr8634382qko.19.1690802346102;
        Mon, 31 Jul 2023 04:19:06 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a15a700b007682634ac20sm3177128qkk.115.2023.07.31.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:19:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH v2 12/20] objtool: Warn about non __ro_after_init
 static key usage in .noinstr
In-Reply-To: <20230728153557.frzmaayyy3auibx3@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-13-vschneid@redhat.com>
 <20230728153557.frzmaayyy3auibx3@treble>
Date: Mon, 31 Jul 2023 12:18:40 +0100
Message-ID: <xhsmh5y60s50v.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/07/23 10:35, Josh Poimboeuf wrote:
> On Thu, Jul 20, 2023 at 05:30:48PM +0100, Valentin Schneider wrote:
>> +static int validate_static_key(struct instruction *insn, struct insn_state *state)
>> +{
>> +	if (state->noinstr && state->instr <= 0) {
>> +		if ((strcmp(insn->key_sym->sec->name, ".data..ro_after_init"))) {
>> +			WARN_INSN(insn,
>> +				  "Non __ro_after_init static key \"%s\" in .noinstr section",
>
> For consistency with other warnings, this should start with a lowercase
> "n" and the string literal should be on the same line as the WARN_INSN,
> like
>
>                       WARN_INSN(insn, "non __ro_after_init static key \"%s\" in .noinstr section",
>                                 ...
>
>> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
>> index 91b1950f5bd8a..1f76cfd815bf3 100644
>> --- a/tools/objtool/special.c
>> +++ b/tools/objtool/special.c
>> @@ -127,6 +127,9 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
>>                      return -1;
>>              }
>>              alt->key_addend = reloc_addend(key_reloc);
>> +
>> +		reloc_to_sec_off(key_reloc, &sec, &offset);
>> +		alt->key_sym = find_symbol_by_offset(sec, offset & ~2);
>
> Bits 0 and 1 can both store data, should be ~3?
>

Quite so, that needs to be the same as jump_entry_key().

> --
> Josh


