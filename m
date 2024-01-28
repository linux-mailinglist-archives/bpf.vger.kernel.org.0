Return-Path: <bpf+bounces-20511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B847D83F47C
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 08:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE301F2316E
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9369475;
	Sun, 28 Jan 2024 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="pHdNGu4N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZN8xO4et";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WYNNQR50"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DA8C1A
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706425200; cv=none; b=pBonnclWBN1e0GlpMzhq00GcqrGGomrcVbmW2I/fDE4JHJ7qNXtu4KmnepHjg6yUSAOLbQwmkJXN5/+LQREHgKb9WEJzR6I/AOssom4e/c01AqmZUTGHZga3X8/7RkdR1QF/nTrDtQh1ZjHGbEYZM2LXUJNDP2sUy55gU62M7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706425200; c=relaxed/simple;
	bh=RmXBTj1IUNnoWZ9xefN6/mW+yZZovFiRmRD+Vz4r3nk=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=XqZtaZdMc2xKlfE246v/7YhzEg7SGd+S9Gn/PvRTyUTlPVA3BQHEVIj+LLdSTNp8qoxHrao0mae2S5mRLbarAepc1G8ROvFSzixvMXa4CYx7mOQDkFUllaKXjUk8q4TzQ5fP7sqYNW/1KnVBKhRn1FYqMfFkJGJhcDFks+nuY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=pHdNGu4N; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZN8xO4et reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WYNNQR50 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2D037C14F70A
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 22:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706425192; bh=RmXBTj1IUNnoWZ9xefN6/mW+yZZovFiRmRD+Vz4r3nk=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHdNGu4N4KYYmjhqy1IuHVGczmG9CBpyA/o8yVDZPOBCRuUmNEpdfBJhG0MunN+n9
	 W18IWdisDa+FJxZan/AJVc+ZoxWy8Wa4FIFKHuCk5a7uPWrp/9ZCNIvxkK4zA69BTS
	 iqKAnCCor4Z2YdquIOtHRx8CFzQJ+H4YTObyUoSo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 01B17C14F6AA;
 Sat, 27 Jan 2024 22:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706425192; bh=RmXBTj1IUNnoWZ9xefN6/mW+yZZovFiRmRD+Vz4r3nk=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=ZN8xO4etexuo4VgtIMgn1pFeHPqQZCHZEX8PAXkqowSagb5DoCyuR04aW5MIp9IHE
 TE8XWYJA/W3mUWm5Iu4PrxCOJSSSr+IJOjJCTAlOs3U9OCqgL90ZcIOQzkRY+w/Tcb
 B+oF4QmBZ7bEvaVpwr8m2lp3D2Ot/Qmqiow8OUvc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5D525C14F6AA
 for <bpf@ietfa.amsl.com>; Sat, 27 Jan 2024 22:59:50 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIuAZqSk99P7 for <bpf@ietfa.amsl.com>;
 Sat, 27 Jan 2024 22:59:46 -0800 (PST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 86002C14F6A8
 for <bpf@ietf.org>; Sat, 27 Jan 2024 22:59:46 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so1658103b6e.1
 for <bpf@ietf.org>; Sat, 27 Jan 2024 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706425185; x=1707029985; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LnTcYNWq7DAEeU1tM0wmF+emUDgfwFMcdllxqKIluCs=;
 b=WYNNQR509wsta+WLm8TV2kj95DbXDtR2m/tOI+caPzoR02U+Rc2WsZYT3kbmCaW3ea
 Q1a4XNPX0ggtam/jwJ9TrMruLJAzCxAXXfAKHeM1ICNrQHqS5G2ZN9uLPa2yXMZDZRQ8
 OAvJrYc4n30N6lIGmAik9JsMdVHOfusEmjt2iaGn8V9I5zW0o2QF+iT6E19Viwekcsad
 lUagG5lKjIYPQqRlrYgbF6ZKmojDohBZNhLoULrK1bFgrXQT2odhHSonMcOSctpfv4bO
 urvuztgCOAcOKa/sn0xJfeKGsWzy7U8dDN827BVjdgMM5BCx1PWOM1BeoK9tQDutuSfM
 PrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706425185; x=1707029985;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnTcYNWq7DAEeU1tM0wmF+emUDgfwFMcdllxqKIluCs=;
 b=u2k8gmrxd9nFd4fcB+gcit0hOoDhQkV2IaVnXwP/hNED2YYs7aD2d9RL+jtwZ1/bnr
 gvIcGH4sMK0+NxugGjfMnlOC73nFSg/Qs31KcfDFvF3ADUrf8DcMMfdxKZCIVg+2YFKY
 Q7XPbek2rqm7eztqVGatU3STHWiORLehEu6bi/CId85TbOPkTCPH839kpJQbvT//gR5g
 JT26kAhwWDn/buj+AvoKaW9VinAlWAZyp9UBxIwMbnzKuQCjg7cSZjrAJxhTdL33wILw
 vQWFoq0/bkcuZtCdLPyTtharJoDbyRFDjR7/4/9omJcsEthuKKtT0rbBRPFf4TmwW8Xl
 uW4w==
X-Gm-Message-State: AOJu0YxXCzB7+QCqSrer19rTHo1oeKyIs4oy6L1RzGH6b4OGvBuf87G8
 6WdYXdht5rYqlFKz0HNOum9b66fL0kGqoIklPiQbqioTKkEe1B9LN5bERR8zP8k=
X-Google-Smtp-Source: AGHT+IFhSSJlMCW/eNyRwYplY3bRD3XWSaAffF+N+EdEL7ZGvhdMXezBtXwy/TpABU7zOnHgY1Js0Q==
X-Received: by 2002:a05:6808:308c:b0:3be:307f:eeb with SMTP id
 bl12-20020a056808308c00b003be307f0eebmr1864221oib.26.1706425185176; 
 Sat, 27 Jan 2024 22:59:45 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 u33-20020a056a0009a100b006ddc335ab6fsm3664876pfg.158.2024.01.27.22.59.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jan 2024 22:59:44 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>, <bpf@ietf.org>,
 <bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
In-Reply-To: <8734uitx3m.fsf@oracle.com>
Date: Sat, 27 Jan 2024 22:59:43 -0800
Message-ID: <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QGkD3DnAsdGbrqwAOEW8A==
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/8R0kYKaxxS6J0YSx45x1-OHdANo>
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

I asked:
> >> What about DW and LDX variants of BPF_IND and BPF_ABS?

Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
> These we support:
> 
>   /* Absolute load instructions, designed to be used in socket filters.
*/
>   {BPF_INSN_LDABSB, "ldabsb%W%i32", "r0 = * ( u8 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_B|BPF_MODE_ABS},
>   {BPF_INSN_LDABSH, "ldabsh%W%i32", "r0 = * ( u16 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_H|BPF_MODE_ABS},
>   {BPF_INSN_LDABSW, "ldabsw%W%i32", "r0 = * ( u32 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_W|BPF_MODE_ABS},
>   {BPF_INSN_LDABSDW, "ldabsdw%W%i32", "r0 = * ( u64 * ) skb [ %i32 ]",
>    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_DW|BPF_MODE_ABS},
> 
>   /* Generic load instructions (to register.)  */
>   {BPF_INSN_LDXB, "ldxb%W%dr , [ %sr %o16 ]", "%dr = * ( u8 * ) ( %sr %o16
)",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_B|BPF_MODE_MEM},
>   {BPF_INSN_LDXH, "ldxh%W%dr , [ %sr %o16 ]", "%dr = * ( u16 * ) ( %sr
%o16
> )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_H|BPF_MODE_MEM},
>   {BPF_INSN_LDXW, "ldxw%W%dr , [ %sr %o16 ]", "%dr = * ( u32 * ) ( %sr
%o16
> )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_W|BPF_MODE_MEM},
>   {BPF_INSN_LDXDW, "ldxdw%W%dr , [ %sr %o16 ]","%dr = * ( u64 * ) ( %sr
> %o16 )",
>    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_DW|BPF_MODE_MEM},

Yonghong Song <yonghong.song@linux.dev> wrote:
> I don't know how to do proper wording in the standard. But DW and LDX
> variants of BPF_IND/BPF_ABS are not supported by verifier for now and they
> are considered illegal insns.

Although the Linux verifier doesn't support them, the fact that gcc does
support
them tells me that it's probably safest to list the DW and LDX variants as
deprecated as well, which is what the draft already did in the appendix so
that's good (nothing to change there, I think).

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

