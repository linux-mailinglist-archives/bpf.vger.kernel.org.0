Return-Path: <bpf+bounces-12636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066987CED2F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2986D1C20DAE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9D394;
	Thu, 19 Oct 2023 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CHDf4FoQ";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CHDf4FoQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtcNj7V+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D638C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:07:55 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2F112
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:07:53 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8C528C1516EB
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697677673; bh=oIgMGGQsyGZQ5E4CTc7E7pFJaPtcVOx7JPJhQzMnB7A=;
	h=From:Date:References:To:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CHDf4FoQ5NSH3tmto5OZPAi1x2LSmP0r6SBlmGtgsHz0HCqb1w5WX5iNd4bu1peZN
	 I931GclGxrkWkgyQrAn0ta2F2EQw/FOQQuEarBiomVwd0KrLGIDlNzsQxKiV5pNw/L
	 h2DMXgz5SCLoIjCJrFXn9tuqqeBA8eHcNrRYA/+k=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Oct 18 18:07:53 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5D729C151079;
	Wed, 18 Oct 2023 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697677673; bh=oIgMGGQsyGZQ5E4CTc7E7pFJaPtcVOx7JPJhQzMnB7A=;
	h=From:Date:References:To:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CHDf4FoQ5NSH3tmto5OZPAi1x2LSmP0r6SBlmGtgsHz0HCqb1w5WX5iNd4bu1peZN
	 I931GclGxrkWkgyQrAn0ta2F2EQw/FOQQuEarBiomVwd0KrLGIDlNzsQxKiV5pNw/L
	 h2DMXgz5SCLoIjCJrFXn9tuqqeBA8eHcNrRYA/+k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4F73DC151079
 for <bpf@ietfa.amsl.com>; Wed, 18 Oct 2023 18:07:52 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtpwGW5nQHEB for <bpf@ietfa.amsl.com>;
 Wed, 18 Oct 2023 18:07:48 -0700 (PDT)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 901EDC14CE4A
 for <bpf@ietf.org>; Wed, 18 Oct 2023 18:07:48 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778999c5ecfso47298485a.2
 for <bpf@ietf.org>; Wed, 18 Oct 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697677667; x=1698282467; darn=ietf.org;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=93iTMdBSd/L52S+O8BZ0+TOR69y0nK2OuLj6qOm2suw=;
 b=WtcNj7V+8k/q/exIENE38qvOLhMfjVHfVUH2A2Bu8WmfdT1YflAzqZdqb5PK0NnQwN
 B305kP3BVKFXwj6dqhyFl/P9Kh8y8F7Q0SaguNl+jWT2Yn+iTeULNaEzYh4/VBBComMu
 uYNuISogG4mOaUq+Sy2mJ6vSi4qBluBeM5K0geI+IDq1brPia67KiOFEPM5sqAVKrG68
 gCLsE0LDuNXYWlEdJFO8IGeHLNlab5w6RlXLN4poIjZzVyCseq4hTZl5AX8oUBsHFUYg
 ONZajZ7eWSKHfXqdBifb3nsLiCxEVC0xv5PuVrTc7DpSOpehAAFpWBn5GSD2Qmm44aM3
 2NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697677667; x=1698282467;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93iTMdBSd/L52S+O8BZ0+TOR69y0nK2OuLj6qOm2suw=;
 b=cWmeO0/3mvbbXJkAXiHhrFT1WmLQtylNIhyNcP2PJs9M8s0Gltz99vJZJaob5IxO6S
 diP5r9mALy2gIA0aNvXucBYH8RIqbR8mELhd7bzRRKBqZzJ+0WpoKI1Rgj8fcRa7+4lM
 P6wK5ImQwdsgWGg3xEXLR8GKynVRQUlEHtJc5XQhdsR5toGMe1piV6u2AsIVLgtLswSu
 OrXv7Ns67Goug5qomWL8b7Nd+J/B+AgX53x+owqYgQrHmL7r9dMLJAqT8d1/cgh0pYTD
 pRurrY6K3uF+QsypMEgNBZoZdBDbGoIHjumqMqwtp/o6rjUB/1/av3d/V+kTWC+FkcoY
 iVMg==
X-Gm-Message-State: AOJu0Yz52ORHx8AtpxTGs/5t/VTEG2dS81cq7TvNF48P1SiMnyo5sWQ+
 QFAivjV7sqQAsHUmdsGjhhrzNRkenHc=
X-Google-Smtp-Source: AGHT+IFqO0u5YdNYimUIslC487swT9BZk+UNlFqvPQBvHDE3YHGQTo315dlj1oN7K/XccD7UpM5Q2w==
X-Received: by 2002:ad4:5b89:0:b0:66d:50a6:da73 with SMTP id
 9-20020ad45b89000000b0066d50a6da73mr1225476qvp.22.1697677667014; 
 Wed, 18 Oct 2023 18:07:47 -0700 (PDT)
Received: from smtpclient.apple (45-19-110-76.lightspeed.tukrga.sbcglobal.net.
 [45.19.110.76]) by smtp.gmail.com with ESMTPSA id
 qh11-20020a0562144c0b00b0065af657ddf7sm376860qvb.144.2023.10.18.18.07.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Oct 2023 18:07:45 -0700 (PDT)
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Date: Wed, 18 Oct 2023 21:07:44 -0400
References: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
To: bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
In-Reply-To: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
Message-Id: <1C8A6FD1-1724-4AD3-A6C9-CA2C427FD32E@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/mLRsSHsAaPm3JHETz_EOvhMaID4>
Subject: Re: [Bpf] Call for WG adoption: draft-thaler-bpf-isa-02
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

Hi all,
  This document has now been adopted as a WG item. Dave, please submit the next revision as draft-ietf-bpf-isa-00.

Thanks
Suresh & David

> On Sep 29, 2023, at 10:28 AM, Suresh Krishnan <suresh.krishnan@gmail.com> wrote:
> 
> Hi all,
>  This draft has been presented at the bpf meetings and has received
> significant feedback both at the meetings and on/off list. Dave has
> published a new revision that addresses all the comments, and has
> requested WG adoption of the draft. This call is being initiated to
> determine whether there is WG consensus towards adoption of
> draft-thaler-bpf-isa-02 as a bpf WG draft. This draft is expected to
> address the WG deliverable
> 
> "[PS] the BPF instruction set architecture (ISA) that defines the
> instructions and low-level virtual machine for BPF programs"
> 
> The draft is available at
> 
> (HTML) https://datatracker.ietf.org/doc/html/draft-thaler-bpf-isa-02
> (Plaintext) https://www.ietf.org/archive/id/draft-thaler-bpf-isa-02.txt
> 
> Please state whether or not you're in favor of the adoption by
> replying to this email. If you are not in favor, please also state
> your objections in your response. This adoption call will conclude on
> Friday October 13 2023 (AoE) .
> 
> Regards
> Suresh & David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

