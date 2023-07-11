Return-Path: <bpf+bounces-4662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3F74E30E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FDD281481
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA164C;
	Tue, 11 Jul 2023 01:12:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039037E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:12:53 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082DE46
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:12:30 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2E3C0C19E0FE
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689037950; bh=ArOAJFZkQ9vEQiGPs1nOn7py3ueWbIslb08qPh824v8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=oh1cvLOK2o52A0Z3cKH6fle9pXbKo3iX3A3/IP8Iju7yK+eBGr9u6FWA9oN9UZIpr
	 P3hYhrWTui1pVfbxvGdNaMZ72JJAssnRfcw1Cxuc5pBhg96OH9++0idr3oAv/hhftt
	 MaxToDRF/F2aylM6XXQvzqXysnHlnK39fa3IHkHo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 18:12:30 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 03317C151099;
	Mon, 10 Jul 2023 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689037950; bh=ArOAJFZkQ9vEQiGPs1nOn7py3ueWbIslb08qPh824v8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=oh1cvLOK2o52A0Z3cKH6fle9pXbKo3iX3A3/IP8Iju7yK+eBGr9u6FWA9oN9UZIpr
	 P3hYhrWTui1pVfbxvGdNaMZ72JJAssnRfcw1Cxuc5pBhg96OH9++0idr3oAv/hhftt
	 MaxToDRF/F2aylM6XXQvzqXysnHlnK39fa3IHkHo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A48C2C151099
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 18:12:29 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.097
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXEoi3T4LDPY for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 18:12:25 -0700 (PDT)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9856CC151096
 for <bpf@ietf.org>; Mon, 10 Jul 2023 18:12:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b703caf344so77380831fa.1
 for <bpf@ietf.org>; Mon, 10 Jul 2023 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689037943; x=1691629943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pex3OXnO+EOM0lLTq/CM4rL/UluIcTGfOZlbj7zTj6I=;
 b=XGk3u5Tmo+EYlpt1Qfu3/ixZ1p9CmSyTZXM9nPs4sHgd8JF0BrcUsfwCKiTdPyv0fh
 5Nm6VbULLqvq46feHjNShV/O+iqzPhLvBjtu9C92+wNM2MnE4m2kBt6v7Mo7MvvOYUCq
 Ti77jV5xXpQDReAOanTur3xQ7/Adz9eIVeA7GJHU4Rb48oDvZTQyoEBk8GXp9K6jJsmO
 1J+jtjCk6Iy8K5UVQRz6+U17WshhgDk3rabbpcOQOn8dwH0Xc7FfOW1Cgu9oqJY5lWPL
 M4lC/4GKoVdXw1Z12E7ts8kikjRuERnsA7itkQZSWL9MNggNTrFNCv+fGJ3gjj70ghhj
 bA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689037943; x=1691629943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pex3OXnO+EOM0lLTq/CM4rL/UluIcTGfOZlbj7zTj6I=;
 b=bfggev0SKYOQb+u/QVC5vd4zAcWij5C1f1ENB2u4adFp6+vPRte+akjlJaDnFSF0gE
 XZ4T4nz/zbct3GNmmAsgUaci88HkHndBoPY4V+RgWNNrOklIf5ZiofxADRFpoX4Oi+J0
 Yky4RCpMI/1ucUCoaCsSBrJfYVOqIa+qvYOvkQ2VA5qumm9RcWfpDIuL2p/DE1wRVyGq
 OKx72UbCUFim5BxPNtXGCBwBZsWPQuafpz6Rgy3W3xMr1o40JVyMX+Ez3ExiHj6U7MdU
 iA89aLsCnQxoNf1XrW2++khAw8RSL3P9cn9o6aMZmpxgBIE1lmOBfDQ7GgMcB5WZhlwq
 5O7w==
X-Gm-Message-State: ABy/qLYNDA7RTjRk+JGCyIYpAGjABGilakfZtJq4GVUZjqcVup65nlRr
 01Y8eat95EuMQM8HWOZjRGVUkALuL0Whatr7Id0=
X-Google-Smtp-Source: APBJJlG/vTWX5lu60jp5eKOQVbHSm2ZmTT39myj8gt9u/9jh77aLQqQjNkUzDJb42F+gfR/wJIzK4SC7aXwHZ5BlIWs=
X-Received: by 2002:a2e:a311:0:b0:2b6:fa42:1b1d with SMTP id
 l17-20020a2ea311000000b002b6fa421b1dmr11980850lje.29.1689037943157; Mon, 10
 Jul 2023 18:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710183622.1401-1-dthaler1968@googlemail.com>
In-Reply-To: <20230710183622.1401-1-dthaler1968@googlemail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jul 2023 18:12:11 -0700
Message-ID: <CAADnVQKjugok8G1ymHC1TgZbTeB=-wvYSU49YgerrLi=F_fP6g@mail.gmail.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler@microsoft.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/R-33Z0QtF9udFK3q6rcwJSWOBSY>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Improve English readability
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6MzbigK9BTSBEYXZlIFRoYWxlcgo8ZHRoYWxlcjE5
Njg9NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPgo+IC1UaGUgdGhy
ZWUgTFNCIGJpdHMgb2YgdGhlICdvcGNvZGUnIGZpZWxkIHN0b3JlIHRoZSBpbnN0cnVjdGlvbiBj
bGFzczoKPiArVGhlIGVuY29kaW5nIG9mIHRoZSAnb3Bjb2RlJyBmaWVsZCB2YXJpZXMgYW5kIGNh
biBiZSBkZXRlcm1pbmVkCj4gK2Zyb20gdGhlIHRocmVlIGxlYXN0IHNpZ25pZmljYW50IGJpdHMg
KExTQikgb2YgdGhlICdvcGNvZGUnIGZpZWxkCj4gK3doaWNoIGhvbGRzIHRoZSAiaW5zdHJ1Y3Rp
b24gY2xhc3MiLCBhcyBmb2xsb3dzOgoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzM2OiBG
SUxFOiBEb2N1bWVudGF0aW9uL2JwZi9pbnN0cnVjdGlvbi1zZXQucnN0OjEwNjoKK1RoZSBlbmNv
ZGluZyBvZiB0aGUgJ29wY29kZScgZmllbGQgdmFyaWVzIGFuZCBjYW4gYmUgZGV0ZXJtaW5lZCAk
CgphbmQgaW4gb3RoZXIgcGxhY2VzLgoKU2VlIEJQRiBDSToKaHR0cHM6Ly9wYXRjaHdvcmsuaG9w
dG8ub3JnL3N0YXRpYy9uaXBhLzc2NDEyNi8xMzMwNzQ3OS9jaGVja3BhdGNoL3N0ZG91dAoKLS0g
CkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxt
YW4vbGlzdGluZm8vYnBmCg==

