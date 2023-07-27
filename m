Return-Path: <bpf+bounces-6064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B357E765022
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58C81C215BE
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B683107AF;
	Thu, 27 Jul 2023 09:46:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2788F9C8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 09:46:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3BFA3
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690451199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/ZtPwamYEdAIqsg4Eha/G0ZWoXDeFDSv2EcRY5ZelM=;
	b=ElA+djzD54PmSaLqPYVLagO86vrJIo5ndba6ka7QFSqTsAKw94/alTgdtXVd9Kuc2RLKAT
	LF06t5/O/KT1UzqYQ0SyR1yjF3COv1plsBkkPA1PvXS2fhzmGJkRa/WHR2CKtU9J8B0+2z
	IvhVpr0VvDy9mOJ+e4O92cZaP/z8hRM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-NGJuPHNmONWYv-jkh4pbBA-1; Thu, 27 Jul 2023 05:46:38 -0400
X-MC-Unique: NGJuPHNmONWYv-jkh4pbBA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb748a83b4so672592e87.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 02:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451197; x=1691055997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/ZtPwamYEdAIqsg4Eha/G0ZWoXDeFDSv2EcRY5ZelM=;
        b=CJZjOVJDompgL0TTcFPX4KPVt2SisyNro0PIQ5x/5joZ+ZfjfX7C8Hl/kX6tQw7m1U
         xBlbO8FMLxK2dafsHRyHnpdK4NxIK8NfViEnNGIJChCLb2r5na3OcpdMCI7YE5OKUrr9
         3XCzQ12hATe0er/I6FhmR9DLnW6ehuMefrLABSt9nY5ulKCw1t0fs0UXZdDQqEcBBC5x
         nNzNECgufKra6zcQP2F/KLyWmE+l3Cg3Ub/kHBAnTe89pYdgIsMrx5nlUrQSANItCfPg
         FLiXuujeEVoEWcUCCza07l+RZrNu5v+O/hAvHF+j9EfBCg80q4pV9eBC35l1B46kxQk+
         eqdQ==
X-Gm-Message-State: ABy/qLZb5sXeY7PPkJqjnrtJpNcpm1zVhOWHWhnZLSBzfC9tq7iK5rvD
	NZ+DrEzkk01P+vJjzCoVFIvnqyCNIQ7t+vwyDNU9L/+uk91y5+0SAmZ+aP5pOFOoRsdds4RArTU
	vh4ABc9Bnmruo
X-Received: by 2002:a05:6512:3186:b0:4f8:7513:8cb0 with SMTP id i6-20020a056512318600b004f875138cb0mr1763653lfe.2.1690451196847;
        Thu, 27 Jul 2023 02:46:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWfc8e6nRRU05KgrIaBfOnm87x2dNku7t4qZB3XfKVqk/Go7XcWjycqa01reYQ5M3BH+RFoA==
X-Received: by 2002:a05:6512:3186:b0:4f8:7513:8cb0 with SMTP id i6-20020a056512318600b004f875138cb0mr1763631lfe.2.1690451196504;
        Thu, 27 Jul 2023 02:46:36 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003fd2d3462fcsm6308442wms.1.2023.07.27.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:46:36 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [RFC PATCH v2 02/20] tracing/filters: Enable filtering a
 cpumask field by another cpumask
In-Reply-To: <20230726194148.4jhyqqbtn3qqqqsq@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-3-vschneid@redhat.com>
 <20230726194148.4jhyqqbtn3qqqqsq@treble>
Date: Thu, 27 Jul 2023 10:46:33 +0100
Message-ID: <xhsmho7jxsn46.mognet@vschneid.remote.csb>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/23 12:41, Josh Poimboeuf wrote:
> On Thu, Jul 20, 2023 at 05:30:38PM +0100, Valentin Schneider wrote:
>>  int filter_assign_type(const char *type)
>>  {
>> -	if (strstr(type, "__data_loc") && strstr(type, "char"))
>> -		return FILTER_DYN_STRING;
>> +	if (strstr(type, "__data_loc")) {
>> +		if (strstr(type, "char"))
>> +			return FILTER_DYN_STRING;
>> +		if (strstr(type, "cpumask_t"))
>> +			return FILTER_CPUMASK;
>> +		}
>
> The closing bracket has the wrong indentation.
>
>> +		/* Copy the cpulist between { and } */
>> +		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
>> +		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
>
> Need to check kmalloc() failure?  And also free tmp?
>

Heh, indeed, shoddy that :-)

Thanks!

>> +
>> +		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
>> +		if (!pred->mask)
>> +			goto err_mem;
>> +
>> +		/* Now parse it */
>> +		if (cpulist_parse(tmp, pred->mask)) {
>> +			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
>> +			goto err_free;
>> +		}
>> +
>> +		/* Move along */
>> +		i++;
>> +		if (field->filter_type == FILTER_CPUMASK)
>> +			pred->fn_num = FILTER_PRED_FN_CPUMASK;
>> +
>
> --
> Josh


