Return-Path: <bpf+bounces-39614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178A975571
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B59B20FF1
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267021A3031;
	Wed, 11 Sep 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GgnY7kIa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GgnY7kIa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxtKS0sr"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5019E97B
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065093; cv=none; b=RAwKWg1n0WjvhBn8o5QeO+yGURTmaQW0tNHJIhCWQj7N1yV7dmlqv8xDn+fSXY1MCqD+4Z/SrquF+L2y16HHlhI8VD6lrLfEQJPPQ0IMcoolHhMgbfnE6Q0+XIbv59ykOIhN9W4Iax+04BOG2nqgZZS7dC7gw4ddMj2hl1M/14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065093; c=relaxed/simple;
	bh=me3+9KCj5O3pr32P+77HjAWNWpET7RkpSEyUzC28q0Y=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Subject:Content-Type; b=cOFYKn+1Uf2mPgjsSQs8vy54vHX6A6PWsyDMjtAJx6vF8iZU880/vopRBrp9Ti5QpRGDCa9EqluCgVDOzNGFpdgzTVo83AqVpEikkVgqGIU8k5jKI8bVMXetZNoYTbIm2RQ3PLbbjLIr+Y45zfRQVs4mB6Yy7JZQe82meXxirvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GgnY7kIa; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GgnY7kIa; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxtKS0sr reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2B9EDC14F5F6
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1726065089; bh=me3+9KCj5O3pr32P+77HjAWNWpET7RkpSEyUzC28q0Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=GgnY7kIaWwV4SYo3ApIfy4LE7UP/FFk40ljIZ/UfI8xBdE4DXPKXOYBdXYm9wpbit
	 QOqcPomPJ8hgNwJPwzlxsxGEuX9GQnhPjw4rxxFFaBh49nQomgRneo6I0eMuVk/pl1
	 GdQ9ALFoRIeYf4ARo3zmL3hnjJs6hzoPwx/rqUmQ=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed Sep 11 07:31:29 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 12D1CC1D5306
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1726065089; bh=me3+9KCj5O3pr32P+77HjAWNWpET7RkpSEyUzC28q0Y=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
	b=GgnY7kIaWwV4SYo3ApIfy4LE7UP/FFk40ljIZ/UfI8xBdE4DXPKXOYBdXYm9wpbit
	 QOqcPomPJ8hgNwJPwzlxsxGEuX9GQnhPjw4rxxFFaBh49nQomgRneo6I0eMuVk/pl1
	 GdQ9ALFoRIeYf4ARo3zmL3hnjJs6hzoPwx/rqUmQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 32705C1D6207
	for <bpf@ietfa.amsl.com>; Wed, 11 Sep 2024 07:30:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pt2LB3Bfkcpr for <bpf@ietfa.amsl.com>;
	Wed, 11 Sep 2024 07:30:15 -0700 (PDT)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id CC32BC14F5F1
	for <bpf@ietf.org>; Wed, 11 Sep 2024 07:30:15 -0700 (PDT)
Message-ID: <eb09643f-0be7-476c-bc9c-067fc38d3637@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726065012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4QjCpeX0EhllRn14vr83aEVRvHtUQfIDSzhS0yYi8I=;
	b=FxtKS0sr0yc9OhkwnHuZxKYmQ370j73xH+WrWnSvy+soFiGICdq4u23Qwb7UK+fOIdB0Jv
	nif4mmdPUeG36TklXpv/d0xOxHJE1gs1q23adTsNLogG+goMDPBUQ2/i5OYlpHu9XkX/bd
	9LcJGNMaD8unTpnzj1z3qOXjJ3PhQ1I=
Date: Wed, 11 Sep 2024 07:30:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org, bpf@ietf.org
References: <20240911055033.2084881-1-hawkinsw@obs.cr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240911055033.2084881-1-hawkinsw@obs.cr>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: E4ZF4GBWYFF2V7WEH2W7QZ4EORVXU3CO
X-Message-ID-Hash: E4ZF4GBWYFF2V7WEH2W7QZ4EORVXU3CO
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_v2=5D_docs/bpf=3A_Add_constant_values_for?=
	=?utf-8?q?_linkages?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/gLF1ZA27qZ-kKu-EB1-jCZ2q0Dw>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA5LzEwLzI0IDEwOjUwIFBNLCBXaWxsIEhhd2tpbnMgd3JvdGU6DQo+IE1ha2UgdGhlIHZh
bHVlcyBvZiB0aGUgc3ltYm9saWMgY29uc3RhbnRzIHRoYXQgZGVmaW5lIHRoZSB2YWxpZCBsaW5r
YWdlcw0KPiBmb3IgZnVuY3Rpb25zIGFuZCB2YXJpYWJsZXMgZXhwbGljaXQuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFdpbGwgSGF3a2lucyA8aGF3a2luc3dAb2JzLmNyPg0KDQpMR1RNLiBUaGFua3Mh
DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5b25naG9uZy5zb25nQGxpbnV4LmRldj4NCg0K
LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

