Return-Path: <bpf+bounces-13102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F067D4698
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493E3281895
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199B79C7;
	Tue, 24 Oct 2023 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CvK7K3rE";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CvK7K3rE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cz6LhvNn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237E7468
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:03:20 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00CDDC
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:03:19 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 68CBCC187714
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698120198; bh=kL369dyjU21eOoxdPeT+z5jQo/VEdqEXGJK6t8T/HqI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CvK7K3rEQqKidMe5SlsA/2pvm6puo+ENc/cMBypeqdiv+axkubhqRDGNlvxImj9QU
	 GJ9sOUdSbajyu9emXoTM4/zhiDdm6y7x6C27Lgl7HgTT1ZtV2hzoEQaZn3LLK09a53
	 jVbNPIypQfzncUnEx7e/L96tOVFSOiw0kJDhEMtk=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct 23 21:03:18 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4C76DC17C53A;
	Mon, 23 Oct 2023 21:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698120198; bh=kL369dyjU21eOoxdPeT+z5jQo/VEdqEXGJK6t8T/HqI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=CvK7K3rEQqKidMe5SlsA/2pvm6puo+ENc/cMBypeqdiv+axkubhqRDGNlvxImj9QU
	 GJ9sOUdSbajyu9emXoTM4/zhiDdm6y7x6C27Lgl7HgTT1ZtV2hzoEQaZn3LLK09a53
	 jVbNPIypQfzncUnEx7e/L96tOVFSOiw0kJDhEMtk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1D68BC1524A3
 for <bpf@ietfa.amsl.com>; Mon, 23 Oct 2023 21:02:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.104
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=infradead.org
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwIIBvCMY9xs for <bpf@ietfa.amsl.com>;
 Mon, 23 Oct 2023 21:02:54 -0700 (PDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0B8B9C151091
 for <bpf@ietf.org>; Mon, 23 Oct 2023 21:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=o2oqEIL9hM7xktXoD6OoCSFGTuIiB9Fg0U9uwi4DxHU=; b=Cz6LhvNnth74dOqxKQrz6xfQKh
 EcFYZvBq8E5rGsi3b0jcokGoG7PRIopiruFoHNTXW1FYDCvy152JnB8dgKtm0MJoxdKxGrnKhBZNS
 iwIpC15zGV8QAtRcd9z/GEDJ51597GX8ofdYGjddnotaD0YrqE5qxSBRfvxFgikYnfTrupnJKgQ1s
 ysTRzgwOT8XxcCbWWVvEyvtJVIANAnqT0BxXWRzM0eclqJS2BgBz51ayUiJllLIic9ruT+TnZN3wj
 Uja/wQQAo5yTdkJPYGlIf3OVDqDCYh8PQmbzJ1KPhzmvBvCPeabHzhEenVoFkz8W/PqBXye9RyG5X
 6oLR+oWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qv8cz-008lpy-2G; Tue, 24 Oct 2023 04:02:49 +0000
Date: Mon, 23 Oct 2023 21:02:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Vernet <void@manifault.com>
Cc: Will Hawkins <hawkinsw@obs.cr>, bpf@ietf.org, bpf@vger.kernel.org
Message-ID: <ZTdB6dJSum4p63oR@infradead.org>
References: <20231002142001.3223261-1-hawkinsw@obs.cr>
 <20231003182650.GA5902@maniforge>
 <CADx9qWjcSoNb=aWpDVV5QxEoUGuDr2=wOOz3AWhjemh6+hzhwA@mail.gmail.com>
 <20231024005528.GA33696@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231024005528.GA33696@maniforge>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/0PcL-pI0igK5yPG9xXsCLCMU9Yk>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Add additional ABI working draft base text
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

On Mon, Oct 23, 2023 at 07:55:28PM -0500, David Vernet wrote:
> > You make an excellent point. Although v2 does not make this change, do
> > you think that a reasonable adjustment would be to simply move this
> > section to the end of the document?
> 
> My initial expectation is that it's not a great idea to reference
> external documents that could change, no longer be valid links, etc, but
> I'd like to hear what others think. Dave -- is this typical for an IETF
> informational document? It seems like if we did this we'd basically be
> taking implicit dependencies on documents we can't actually control
> (because they're not IETF), but I have no idea if this is normal or not.

IETF prefers IETF references, and if not stable standards-like
documents.  Even those will get careful review (talking as someone
with a draft that has normative SCSI and NVMe references right now).

For non-normative references this is a bit relaxed, but a random url
that can change is never acceptable.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

