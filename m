Return-Path: <bpf+bounces-20752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544718429C2
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AF928A8A1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5B128368;
	Tue, 30 Jan 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="uDillfbZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="CP1WY7UF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fIYjsVbr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06476DD06
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632931; cv=none; b=tZdTEK01jUo0wJpmbpXnBH8BM7sHWt72zrNfSpYO2htxm3ifnrABGS9GndROzW8FEWQq+Mz7dbp3jH0E6Oxb/ARLif007Gt8jJ7VsiiIyH1+EbYMF9/YHsidOsZ+QHu1e+Z+eqgGB+ZIieLwZjY1+cLNT4ap9uhWfzIxCfbvTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632931; c=relaxed/simple;
	bh=NdU5Zcr2RlN6MYIdxAtdfkR1rUNOLkF5G6QeoteDMGE=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=Pb1X+Dl+80SSPFZ7VWswGBqMFqcuge7N6vAf1fliacd7uTNswWGpfF3epyenM0wQaTDCaHgZkhQS7t1182iYjwQ6ATwf5QxfEVdGDYeeq7Rx69zO3Revg2S2ToNpJSeJoCqxcB34YzRl9Usw/oW8zE7XN00phNl/5Ublo2i5qHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=uDillfbZ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=CP1WY7UF reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fIYjsVbr reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6B970C1CAF76
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706632929; bh=NdU5Zcr2RlN6MYIdxAtdfkR1rUNOLkF5G6QeoteDMGE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDillfbZXvVTN1EglSGNDmaXU3rOFut02WquUSg9xHk2FKRkVexEuOxuck1JZJ/h9
	 XttAIK+F+wykQ27CBcm1Cwwqhiy4n0nc+L0QuPbnTLR/CgBFtUk1DXq49FepvYBQTX
	 DCQ0B0r8Cik7uZkpeNtYBFXuMIbU4C59j/WWDtQI=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4CE86C14CE55;
 Tue, 30 Jan 2024 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706632929; bh=NdU5Zcr2RlN6MYIdxAtdfkR1rUNOLkF5G6QeoteDMGE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=CP1WY7UFFIW7eH6cYvOkLbL1H5Sd3gNxEZxHoyY88rB/uh5j9ifOtA+US2bqIyYk0
 6VbwwuLjbyX5nA2gR+YALUGOa/sByQj8zTFGyJifKPlRuyTzcmEAdzbuArnygZlsPT
 XRu0rdPJMiH2WqWl07K8krydxksTho7a1f78yk7k=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E45D7C14CE55
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 08:42:08 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSjw0aoEOKJj for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 08:42:05 -0800 (PST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 15B6FC14F71F
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:42:05 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d8df2edd29so914058a12.2
 for <bpf@ietf.org>; Tue, 30 Jan 2024 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706632924; x=1707237724; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wwt+nkrzFpFAGBz7peNidpEu0qQyu3Q0/t5OxDhzD84=;
 b=fIYjsVbrqnxC/N1veXn5cj0wiiyCrJgueSQ9r2rgVs0DA62oPYRl4xs+LLGMpAcSMT
 KkRJe3pK+MHNMT4H511D4+f/PwzuaL3O0LyO3mPGYjIQ+yIo1hNsjIQ3/PJhzcxdJv7f
 +I9bx+DXCF6TXHYUV+ANyGiiuC23XN12WEbPsuQo0TT7iW58GVkOzy7DI2O+fTfdEXhi
 hY0ANjT8iwJv2cKBccw8zf0MJHm58bk0WlZZoKaK3UDz3b/1JkBfwMRHk3+ivBKKTP3Q
 zdZ/6UX2EizfddEM8kWHvpJc/LZuaWVi+awqgjc7ifqqHxT2h4xKpPQ3mCj+865W7kmm
 gBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706632924; x=1707237724;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wwt+nkrzFpFAGBz7peNidpEu0qQyu3Q0/t5OxDhzD84=;
 b=DRrn1KnMuIyz/ugZacDi3sAMwZVzVJZ9mmHr8wuEis3EpRVII2nNOVfCtqIWCA4wlh
 QMo/TU8CfXw8XtyQjkCO/EJdHg+/wn49+nW5AiblDuSHxGQsWNaYnguQXx2J7cOrqraF
 Il+tcER3bKM6xLK1RE8vdCy5y2nl65DVOowhvDwOOC4gURFjFEb7+X8LvP31euM2Aa8B
 DtZQNtjDNn1Hd3a+hbxpij3jGMgkzh4qKuFqak3w6ZkN6kW/8vp9kUTEo3HPwqDbh6RA
 yeENgubLbsx2ziNCfbyuGyheFOiNfPAqAGY2OeaSSckicpU7l8HknzmeRPO5hgEkqLKu
 9cPA==
X-Gm-Message-State: AOJu0YyAJp6QOTI1mHM41JhP3Kiqmiy5gKIaPEMLLer28MEAyQl9xBBn
 c/uzAcZvUCIRshXlTKbmHEz3WC5qfMRaXBDEd6iOkA/lt82pDRpg
X-Google-Smtp-Source: AGHT+IE3Crn5PmjvTb/24FRQF6Gbs+psxnsp0T1FsTWwr9v0VkJ2bl6JAEiTGYDVTaJHqS/aGL0JhQ==
X-Received: by 2002:a05:6a21:3385:b0:19c:92ef:4d66 with SMTP id
 yy5-20020a056a21338500b0019c92ef4d66mr5467496pzb.1.1706632924296; 
 Tue, 30 Jan 2024 08:42:04 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 h21-20020a056a00219500b006dd8985e7c6sm7981535pfi.1.2024.01.30.08.42.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jan 2024 08:42:03 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
 "'Dave Thaler'" <dthaler1968@googlemail.com>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
 "'Yonghong Song'" <yonghong.song@linux.dev>, <bpf@ietf.org>,
 "'bpf'" <bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
 <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 <071b01da5394$260dba30$72292e90$@gmail.com>
 <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
In-Reply-To: <CAADnVQJ7Phg_89MCVNtjh1EJTxEk5S++rFhpcnukMvn6sL351A@mail.gmail.com>
Date: Tue, 30 Jan 2024 08:42:02 -0800
Message-ID: <073101da539b$40dd6b60$c2984220$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbroCN+NFGgGJMAgqAYfmIS8CWWZiQq/HlkoA
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/UkPkQn46m5jhQemsFg5HAul4fLo>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
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

[...]
> > > Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
> > > It's a legacy insn. Just like abs/ind.
> >
> > Should it be listed in the legacy conformance group then?
> >
> > Currently it's not mentioned in instruction-set.rst at all, so the
> > opcode is available to use by any new instruction.  If we do list it
> > in instruction-set.rst then, like abs/ind, it will be avoided by anyone proposing
> new instructions.
> 
> Yeah. The standard needs to mention it as legacy insn.
> It's such a weird ultra specialized insn introduced for one specific purpose
> parsing IP header. tcpdump only. Effectively.

Thanks for the quick answer on this one.  Will do.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

