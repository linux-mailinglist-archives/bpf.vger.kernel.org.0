Return-Path: <bpf+bounces-7264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8D77460E
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3121C203BD
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227D154AE;
	Tue,  8 Aug 2023 18:51:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5F13AFA
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 18:51:58 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6922914
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 11:24:54 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CA248C159A24
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691519094; bh=C+9+CSB0nt6IvmG32c4NRb1wMtiaoiiLgzhQ9PFs88M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=GlyXpGnjg4dXudlJBwFtHSpMw0uoy16so67HCpJG0nRx8vCQsqDbm2y+VZhfvgLH4
	 7sQfIoxTjgNKTgXcgUTeDfNIqP3L6q8VoWoZmDDka5u2PrLhdZWvA9Y4SeV+oYf0vG
	 LWJwjvnFogD1opxKKXDph7l4EjnjbZAiOEG3Howo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  8 11:24:54 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9FC91C151992;
	Tue,  8 Aug 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691519094; bh=C+9+CSB0nt6IvmG32c4NRb1wMtiaoiiLgzhQ9PFs88M=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=GlyXpGnjg4dXudlJBwFtHSpMw0uoy16so67HCpJG0nRx8vCQsqDbm2y+VZhfvgLH4
	 7sQfIoxTjgNKTgXcgUTeDfNIqP3L6q8VoWoZmDDka5u2PrLhdZWvA9Y4SeV+oYf0vG
	 LWJwjvnFogD1opxKKXDph7l4EjnjbZAiOEG3Howo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DD803C151992
 for <bpf@ietfa.amsl.com>; Tue,  8 Aug 2023 11:24:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.406
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ga2ER55FFoP1 for <bpf@ietfa.amsl.com>;
 Tue,  8 Aug 2023 11:24:48 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6C730C15198D
 for <bpf@ietf.org>; Tue,  8 Aug 2023 11:24:48 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-40a9918ec08so39616171cf.0
 for <bpf@ietf.org>; Tue, 08 Aug 2023 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519087; x=1692123887;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeZ+lTBYLw0R6FU/F/eARhmKcEJ04alk4SdxU6Lwfnk=;
 b=QqA/bm3J3/DNR41cMh//NU41BE2EGGEHAWjVo/uDiZnKH3kjnsOM/qfJ/anK4ZRwPA
 eZ92EKrUQ9YI296kfQKoAh4zJFQnqTGzDwUAnjtNCWRDCJz8s2gdZezsYWnhyb3wr3z2
 JIblksc5JnCeGn9ZR3589nIpY/+wjhYbhLF+eBpQYYpzMd4TPeNT7sA1PM+Npa7CbNVc
 OYKzG2GtATyiY+t3fqHYpXhb0BbRuDhIhwezreHYR1GlXhTmTCOVOQzI8uP6uAP29+40
 ADRWWnM3QhqZBUism8GnWtcEqqcba/cpjm6zidROg6rGMfQWPyEYgbEx0B7YGr/pxJ9S
 I20w==
X-Gm-Message-State: AOJu0Yw+Hxoz8FIzEn1noVNAi6vBDwvlxStWayJVVWZJMy+sWGviUh2H
 6f9Y2Q/HX6gBmLnDNgxbaJg=
X-Google-Smtp-Source: AGHT+IGPaDZGdg80zPBK3G1uLfR4TIVBiZ2v5VDq4HPtZLLrQlHI59zI70NBNk+rFoaCbD9733K3Zw==
X-Received: by 2002:ac8:7d45:0:b0:40f:df11:8bf0 with SMTP id
 h5-20020ac87d45000000b0040fdf118bf0mr747131qtb.14.1691519087287; 
 Tue, 08 Aug 2023 11:24:47 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b076])
 by smtp.gmail.com with ESMTPSA id
 cb7-20020a05622a1f8700b003f9c6a311e1sm3548577qtb.47.2023.08.08.11.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 11:24:46 -0700 (PDT)
Date: Tue, 8 Aug 2023 13:24:44 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230808182444.GA1158877@maniforge>
References: <20230808052736.182587-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230808052736.182587-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-l99Oq6lPgWqCVKGnTjITtUlYYs>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Fix small typo and define semantics of sign extension
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

On Tue, Aug 08, 2023 at 01:27:32AM -0400, Will Hawkins wrote:

Hi Will,

This looks great, thanks!

Acked-by: David Vernet <void@manifault.com>

> Add additional precision on the semantics of the sign extension
> operations in eBPF. In addition, fix a very minor typo.

Just for future reference so we can have consistent nomenclature:

s/eBPF/BPF

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

