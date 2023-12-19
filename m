Return-Path: <bpf+bounces-18327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F8818F99
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B21288482
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631E37D32;
	Tue, 19 Dec 2023 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CnxKKcKW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="oJEYYntZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="msutlS7v"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30837D11
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id F133BC2395F9
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1703009731; bh=xV0Koe8FDQ89I15TksZ3rKgTxz2yK5w/zyhgJifgG5c=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CnxKKcKWA5Cx1jw1/W1Vgwb6N4oyKOyLfdrh8vBxfeSTdfnWHnuU8t41na8IvIZAw
	 PH9oszDGILhcahMcB6XHR/NfRXHi9wwW0jyq6MkdFd9SstAkgWHcdO+Yi8WLUzNY8F
	 8DbFribVpvQSA5qE9P07mqRgUUfobQ4FrZfwcH6I=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id CC543C137380;
 Tue, 19 Dec 2023 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1703009731; bh=xV0Koe8FDQ89I15TksZ3rKgTxz2yK5w/zyhgJifgG5c=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=oJEYYntZZlevLb498iSzBk3254W3O2pYC+Vq4HQv/ypNHiw4f2q3FhF9r//UyHEGc
 a2GEGlxK8rJcgxpExqcDaoiPlQikpPYywl5UvPSMjqfN81AYYI2qfAZhT/4cISYBYX
 hOl8PHDqytVDxQuyvtsAouTHQttjwUV/W+5P3tzM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F254CC14F5E4
 for <bpf@ietfa.amsl.com>; Tue, 19 Dec 2023 10:15:29 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Pf9w7O9hnLm for <bpf@ietfa.amsl.com>;
 Tue, 19 Dec 2023 10:15:26 -0800 (PST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A4659C137380
 for <bpf@ietf.org>; Tue, 19 Dec 2023 10:15:15 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7b7d55d7717so94767439f.2
 for <bpf@ietf.org>; Tue, 19 Dec 2023 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1703009714; x=1703614514; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vnnNBxYCIBTHcSzoKvUPCssZazPeCD1gELqmymS6yrU=;
 b=msutlS7vbChnzHBvtXpxuGiaYTYXhud7SgJ0g5bXgAo8poH88xBm9yMSeizNuDsv/D
 wQoP+QusHYxhAWktPftVz/DmbL8YPMiVmSvylrbZF5LLa1wMy8MJyfbQ5xAznJtaDTfb
 hOc9eAlkyt6ZCnLZdKY2hyqqtte+uax4wHwEmek3kw+t91d1hZ4UAmmtNZLJ5m3WiK4J
 XzLdM82ay1+WfC8YEs/oV8nVhR5iSmf8t4sH1wPc59kXHqrjKIpCX/ffbuoEDtpPQAi7
 wlIkVscCpb/vnxS5NzHtE2LDHBXT/3S9jUOUBTxtEimgtQnxo7NB7GR8jTIbQz6Z31qO
 1NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703009714; x=1703614514;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnnNBxYCIBTHcSzoKvUPCssZazPeCD1gELqmymS6yrU=;
 b=wouo1o0xuJcLx4BIrtd75ybQoYYXDtPr21lU7JpJfRdSWYD9bh86nS4tnZeJuTokWj
 KVrucERmv2jWo0TMBBXGGLeD86BgXLAmzP/Dmn992s/B+K8SPmxvf0pWx9/hRSm64l1E
 Zjr7E8euMuF1aTZP9TWE5ROMIANZIWgMGse3b73DP7IcM6U0Nx/eeNphEyzFZefV8J84
 5z1w8xWfSjuEdkd3n+vr2YDUcHYYE+MjmYvnGBQZ+1BRS+JdUUS5ZGv9fc8cyHFoKsub
 CQc9JarVZDtuD9grECwmUhKv6eWfQOtuG4No6H8umw+nAhufVgVfrbEDHHiUToEOuLGe
 YXyQ==
X-Gm-Message-State: AOJu0Yx3jnFMgUSe9TG5WVETi+bnTYYjEhzNZSq5MsIYMqt5/0qTZ3T8
 t4LMnQsxjUVky21A72N2wkU=
X-Google-Smtp-Source: AGHT+IGhiXMDScIoM2tRIe5Ld5PHlfr6SGhdohM4dO1GheQNnylpt5cFGRdPHkCjPfMLlPEAV6AqSA==
X-Received: by 2002:a05:6602:2f10:b0:7b4:3be1:91ac with SMTP id
 q16-20020a0566022f1000b007b43be191acmr24938798iow.22.1703009714504; 
 Tue, 19 Dec 2023 10:15:14 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 k7-20020a02a707000000b00466ddd26820sm6271293jam.163.2023.12.19.10.15.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Dec 2023 10:15:14 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'David Vernet'" <void@manifault.com>
Cc: "'Dave Thaler'" <dthaler1968@googlemail.com>, <bpf@ietf.org>,
 "'bpf'" <bpf@vger.kernel.org>, "'Jakub Kicinski'" <kuba@kernel.org>
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com>
 <20231212233555.GA53579@maniforge>
 <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
Date: Tue, 19 Dec 2023 10:15:12 -0800
Message-ID: <09e101da32a7$4f749aa0$ee5dcfe0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKaT4/11CAPHwhRd3AqhQv3W/OzVwEwRWUPAqgd9mMCsPCsZAM3MzMrAU5aAh0CJOkFhgFiTxI+Acm6TbKura/J0A==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/J1J_AL_-rOHftRVGxgM3jxAalSw>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]
> > Well, maybe not for Netronome, or maybe not even for any vendor
> > (though we have no way of knowing that yet), but what about for other
> > contexts like Windows / Linux cross-platform compat?
> 
> bpf on windows started similar to netronome. The goal was to demonstrate
> real cilium progs running on windows. And it was done.

The eBPF for Windows project's origin was independent of Cilium per se.
The goal was to enable us to write BPF programs that worked on both Windows
and Linux, rather than doing similar work separately which would double the work.

Once the work was far enough along, Cilium then became an interesting test case
to use in a demo since it was popular and recognizeable.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

