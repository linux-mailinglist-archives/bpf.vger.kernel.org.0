Return-Path: <bpf+bounces-1327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FD712BBB
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21C11C210E7
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66CF28C2D;
	Fri, 26 May 2023 17:26:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12B271F6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:26:32 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B48F3
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:26:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7A8BEC61F339
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685121990; bh=xjpnvCbbETW1KV/kErkZFzCsx5f0uyGblEFsLlquynk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Qx+ludVzC5dAT2XQLB4zzsBtOizYKF1jXgqjSzgM5vDQ7QsQQAHLHCybFq4gryZMH
	 nXntfRKI/iMQRQK6dUkR+S+2wBYgX03oylaP2TXYae6bDjBqRgpu6MuMLWFP2TzmIx
	 6cNOiaaqZWYaddZ2uO6Wv1dSe7Ek94KpPpgfgvD0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri May 26 10:26:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4869BC61E06E;
	Fri, 26 May 2023 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685121990; bh=xjpnvCbbETW1KV/kErkZFzCsx5f0uyGblEFsLlquynk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Qx+ludVzC5dAT2XQLB4zzsBtOizYKF1jXgqjSzgM5vDQ7QsQQAHLHCybFq4gryZMH
	 nXntfRKI/iMQRQK6dUkR+S+2wBYgX03oylaP2TXYae6bDjBqRgpu6MuMLWFP2TzmIx
	 6cNOiaaqZWYaddZ2uO6Wv1dSe7Ek94KpPpgfgvD0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 248D0C151711
 for <bpf@ietfa.amsl.com>; Fri, 26 May 2023 10:19:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.553
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3vEmAcFopHZ for <bpf@ietfa.amsl.com>;
 Fri, 26 May 2023 10:19:33 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5A00BC1516F3
 for <bpf@ietf.org>; Fri, 26 May 2023 10:19:33 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-625bb54004dso11428516d6.1
 for <bpf@ietf.org>; Fri, 26 May 2023 10:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685121572; x=1687713572;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbDQtFpjPgfxrzi2lMXXqeaTE0rEM6xDO1oipT+ez5A=;
 b=UQ26vK0C2yCQV7fNzIt9fv/m3ptjCQe8jzizBIfrEufd+nY3E+uVZyS4yhsPQCiFbQ
 BFl5dpKqRRmlmw6O5o/UkyLZyW5QsDzQv6TegQrPkB0TIjEEUIVK6bSATbyLO2Oe/CNN
 8sZauIaZH7QpK8JoxZOidM08vfr/dZAivO6qqpPY4KjXOHF3VzNBZLj2z1o3/zTZapU9
 iRxkhCld5k7ZHPFyp54SVw2RsQoLBRbwC2BO2NC4aUusHkTFYcOZOgfaUNIsPeb2zNjX
 tu4ARhbnviXUp3L+UxQvMv3pWNN2AfHYajIX9JvF97WsYK6S0jZxuyHhfjyHrYdySUxq
 YaCw==
X-Gm-Message-State: AC+VfDwIS+aGD+ZLVDMsE2V4abAuOAIZbS2udk5QhkCwj4qQIVQhp4sW
 6HUCVWo0+l2glvpLD2zMGjM=
X-Google-Smtp-Source: ACHHUZ7e6yuvFViApkFf/8nuTNm/ttPOkI/RCt8nQ2R0OoR/HO0baOQ904kXQvbCd6yfIFLgLf20JA==
X-Received: by 2002:a05:6214:400d:b0:623:9a41:ea00 with SMTP id
 kd13-20020a056214400d00b006239a41ea00mr2313235qvb.22.1685121572214; 
 Fri, 26 May 2023 10:19:32 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5368])
 by smtp.gmail.com with ESMTPSA id
 t29-20020a05620a035d00b0075b27186d9asm1287788qkm.106.2023.05.26.10.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 10:19:31 -0700 (PDT)
Date: Fri, 26 May 2023 12:19:29 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
 Christoph Hellwig <hch@infradead.org>,
 Michael Richardson <mcr+ietf@sandelman.ca>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>, Lorenz Bauer <oss@lmb.io>
Message-ID: <20230526171929.GB1209625@maniforge>
References: <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/vGiWy6KAeEo4MsJsJNZAnCDqJ6Q>
X-Mailman-Approved-At: Fri, 26 May 2023 10:26:29 -0700
Subject: Re: [Bpf] IETF BPF working group draft charter
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

On Fri, May 26, 2023 at 05:01:57PM +0000, Dave Thaler wrote:
> David Vernet writes:
> [...]
> > I'd like to highlight this line in particular:
> > 
> > > This means any version of this specification published at the above
> > > link can be regarded as stable in the technical sense of the word (but
> > > not necessarily in the official RISC-V International specification
> > > state meaning), with the official specification state being an
> > > indicator of the completeness, clarity and general editorial quality
> > > of the specification.
> > 
> > To my reading, this sounds a lot more like a (strongly advised) informational
> > document, than a formal standard.
> > 
> > > The eBPF Foundation could publish the equivalent of the
> > > riscv-calling.pdf document above, but we (the IETF and BPF
> > > communities) decided the IETF was the best place to publish such
> > > documents.  As such, I envision an IETF RFC for the BPF calling convention
> > that is very similar to the RISC-V standard one above.
> > >
> > > Given the precedent, and the need in BPF, I don't see a problem.
> > 
> > Just to make sure we're all on the same page here: Are you proposing that we
> > publish a formal standard for psABI specifications, or are you proposing we
> > publish an informationl document?
> 
> In an email last week to the list I mentioned Informational as a possibility.
> I don't have a strong preference, but I have a weak preference for Proposed
> Standard status.

Thanks for clarifying. Erik, Suresh and I met yesterday to try and find
a middle ground that addresses everyone's concerns, and we came up with
[0].

[0]: https://github.com/ekline/bpf/blob/ekline-patch-1/charter-ietf-bpf.txt#L31

Does that sound reasonable to you?

I must admit that I feel quite strongly that a Proposed Standard is not
the right move for now. Many of the existing ABI conventions that exist
today are simply artifacts of somewhat arbitrary choices that were made
early-on in libbpf. I say "arbitrary" here not to imply that they
weren't well thought out, but rather just to say that like many other
decisions in software projects, they were made somewhat organically and
without the benefit of hindsight and a larger corpus of participants.

> As an implementer, I would want to make sure that ebpf-for-windows,
> PREVAIL, and uBPF all do the same thing, ideally matching Linux for everything
> the former projects support, to allow using consistent tooling.

I completely understand the motivation. Hopefully an Information
document will address those concerns? Let me know what you think.

- David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

