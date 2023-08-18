Return-Path: <bpf+bounces-8104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF73781405
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBC91C21652
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B51BB4A;
	Fri, 18 Aug 2023 19:59:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BF19BCC
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 19:59:50 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066126A4
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:59:48 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CB1FDC1526FB
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1692388787; bh=3J0pE3GVJjEqbaLy2yRD+JdfCvYJZsl6qAyiGWXOs/g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=h/JnQ5eVdRrHmw+TOD8VHfx4w4ejLfeHRIsn84Czn68ejMHqbpdFXXNj7jrR6KD8d
	 UUFr8gmwBDTJ9J9xJ7j7dpgahubhULBs9b0Ubgjf0Z8T2Xq5UlE/oRo+ZGgaIQ2pzh
	 +ORF4KN7YIsi6ahYFZnDHtVSHn3+VKFDMofCI6nk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Aug 18 12:59:47 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7CD27C1519BB;
	Fri, 18 Aug 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1692388787; bh=3J0pE3GVJjEqbaLy2yRD+JdfCvYJZsl6qAyiGWXOs/g=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=h/JnQ5eVdRrHmw+TOD8VHfx4w4ejLfeHRIsn84Czn68ejMHqbpdFXXNj7jrR6KD8d
	 UUFr8gmwBDTJ9J9xJ7j7dpgahubhULBs9b0Ubgjf0Z8T2Xq5UlE/oRo+ZGgaIQ2pzh
	 +ORF4KN7YIsi6ahYFZnDHtVSHn3+VKFDMofCI6nk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A0140C15109F
 for <bpf@ietfa.amsl.com>; Fri, 18 Aug 2023 12:59:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.407
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcDO_Vq-iVkg for <bpf@ietfa.amsl.com>;
 Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 2E635C1519BD
 for <bpf@ietf.org>; Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-40f0b412b78so8416381cf.3
 for <bpf@ietf.org>; Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692388780; x=1692993580;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5ErGUEjSwHR/cJmJEzPuQ1g6S7P90KrVs1EyxEQC0A=;
 b=Mk8G1c5nec3cxoV78uiEiLLl0wSZuxvGyhXN+1ARcNHUe3TORhvkoOOM/pfFuQVLDl
 RHTQN5ZDU5mdWK+Ohrgl8w3tRniQegh/OvOlet9d9l1Y5syTn+v64jEf/SVpbcSSY+Z5
 JOiBZkX6r51DPKWqhiN8lv+huH1KM0XUfMl1PhScBhP5Ac8OEaEGvu8VE8nGNv+yVmsw
 HvolEMbxLk+KMnhn9TpYVul2KIYy4+njiLAoAbgp+WNBVsvQj1yvcZKbW6xUafBKekwu
 X3USmx2v71IEZcRMEDca6Tidq6Nq69iXNS8KZo5aH2x6afozUpQ53cZBuLtq9acXfHIy
 v2sw==
X-Gm-Message-State: AOJu0Yz9tHSnd8PZdPtlnd1E3rFg35QNgI4Pr6/lTRH/8UskQoTAwjkv
 QJcqMF/EpmtEq+8d6kjDUjt+j9P8sI7HSw==
X-Google-Smtp-Source: AGHT+IGlTobRFipdflEDnn3F0R+nnnGnNW+QTnFleu/xwvSbjEeINuMRXcx0ve7txYygJ69WUYwKRQ==
X-Received: by 2002:ac8:5f11:0:b0:40f:fe6b:6b5b with SMTP id
 x17-20020ac85f11000000b0040ffe6b6b5bmr149436qta.66.1692388780036; 
 Fri, 18 Aug 2023 12:59:40 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:13f7])
 by smtp.gmail.com with ESMTPSA id
 hz6-20020a05622a678600b0040f8ac751a5sm717656qtb.96.2023.08.18.12.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 12:59:39 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:59:37 -0500
From: David Vernet <void@manifault.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dave Thaler <dthaler@microsoft.com>, Christoph Hellwig <hch@infradead.org>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Message-ID: <20230818195937.GD14411@maniforge>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge>
 <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
 <20230814161759.GF542801@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230814161759.GF542801@maniforge>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/3RGBNBexJ4aAjoixQwz5eL3ofFk>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 11:17:59AM -0500, David Vernet wrote:
> On Fri, Aug 11, 2023 at 02:36:04PM -0700, Watson Ladd wrote:
> > Dear David,
> 
> Hi Watson,

Hi everyone,

Watson and I discussed this today in more detail over a call. I think
we're now on the same page, and I want to update the lists with where we
landed so others can weigh in. The TL;DR is that the ISA document as it
exists today is trying to toe the line between being two different types
of ISA documents:

1. An ARM/x86-esque ISA document that exists somewhat in isolation, and
   just defines the encodings and high-level semantics of instructions.
   For example, if you look at the ARM A64 Instruction Set Architecture
   for Armv8 and Armv8-A document, it literally just jumps straight into
   encodings and high-level semantics of the instructions. There's
   literally zero information about the ARM memory model, execution
   environment, etc. All of that is captured in separate architecture
   documents.

2. The RISC-V ISA model, which goes into significantly more detail on
   the architecture of RISC-V, and formalizes not just the instructions,
   but the execution and memory models, memory consistency model, etc.

I am (and I believe Watson is as well following our discussion) of the
opinion that our ISA document belongs squarely in the first category,
and shouldn't try to also fit into the second. We're defining the
instruction encodings, and describing their semantics at a high level
without much formality. This is intentional -- our WG charter specifies
many more documents that cover all of these details (some of which will
likely be contentious and require a lot of thought and discussion) in
the proper scopes. For example, our planned documents include but are
not limited to:

- [I] an architecture and framework document

- one or more documents that recommend conventions and guidelines
  for producing portable BPF program binaries

- [PS] cross-platform map types allowing native data structure access
  from BPF programs

- [PS] cross-platform helper functions, e.g., for manipulation of maps

- [PS] cross-platform BPF program types that define the higher level
  execution environment for BPF programs

With all that said, I think our ISA document would improve a lot with
the following changes:

1. Removing all the ABI-specific stuff from the ISA document.  For
   example, calling conventions need to go. This was discussed at IETF
   117, so should hopefully be non-controversial. I'll send a patch
   later that moves this to a separate abi.rst document that we can then
   fold into Will's work.

2. This wasn't discussed at IETF 117, but also removing extraneous
   verbiage such as the "Helper functions" and "Maps" paragraphs, and
   maybe more such as "Platform Variables". These blurbs are useful for
   giving some context on the actual instructions in the ISA, but
   they're insufficient on their own to be of practical use.

So the TL;DR is: let's make the ISA document just an ISA document.
We're in it for the long haul, and the time to properly introduce,
define, and explain all of these concepts is when we write the documents
that are meant to capture all of that information.

Watson -- please let me know if I've misrepresented anything. It would
be great to get others' thoughts as well.

Thanks,
David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

