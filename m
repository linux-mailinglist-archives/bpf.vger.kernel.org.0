Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5E1B11C5
	for <lists+bpf@lfdr.de>; Mon, 20 Apr 2020 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDTQje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Apr 2020 12:39:34 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53741 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgDTQje (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Apr 2020 12:39:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D53D43FC;
        Mon, 20 Apr 2020 12:39:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 12:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm3; bh=tGKhGxcuXz62vF/Dg9q0OABBh
        DVINldw8jc1jRGeLhc=; b=qkOlMFp/X9vY4inHxrr+E4XYt42YrXgAI81JZw9R1
        h+XWc9BA3oNMV3zEIDRGsbPKO7rI+EURrl9kpHk4fs+TJu/xXcoTENeHIwjj32ry
        PTottywSu8CRAYsvTAR4Kf1Y8Y4P4wxxLQhCTA+7BC+SXuPRTk4QrJlatXeJcCw9
        +XjJw1knDsjiSmyeDmZ4SQ8c83OQAJEmYojYZVDJ/E4nFLqr4Wje54BNJDwwDIyl
        0h+Dec+u+ymCYeHbDuxnCCMfnJtFpyOx7UXFD6wWu3kNgsFI1hpKOZsovzeRILs6
        LJYiKi6mZSf0uJjZFgtQ2YRL0qXHsO9rHeX4e60ubl9aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tGKhGx
        cuXz62vF/Dg9q0OABBhDVINldw8jc1jRGeLhc=; b=jF6OArxtd/Tba2z2ojqF/Z
        hOtQWDNurydWxwOQhJj5Tg7/Cql9WCs8+3d/dCMomshSceJt4UmfeURPCcpojPkU
        /SLItdC9QWITcrUGuipqx9WjMwvuyBsz9Ki3LhxmS/m+vb1ApvkNbzMkAgjXjwkD
        LsFeWak+5spj9lUfzEheJHyxDjtq+fmpwTW7idWcpGQd9z6jwpPKV4D35L167vuE
        gVfDTUjN7+rg6EDc14ijDaPxtjHKXNv1LSvHQR9OefcNoKz3MRzA2L82Atr0Rrjc
        PiZDB0D8XCy9JF36XwBOxyh066fZNTJeTexKrhe6d6bXcDe9fYETmvPZKHUNStWg
        ==
X-ME-Sender: <xms:Q9CdXlxtXN0t1UqHLszcP4AZIN2xohsgMsz_WPv44POS8Y3fToMhoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdejnecu
    hfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecukf
    hppeejfedrleefrddvgeejrddufeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Q9CdXsZpilasjnTPfr-qtnR8Zk8hBDQzFQFiksBgYiAPulKeMq7Jvg>
    <xmx:Q9CdXhtqWVpxi3Yc7ju8c5d1J3gaCupHelbVvASUzyq4rERs5QpYqw>
    <xmx:Q9CdXhNaqsUim6fToeDgXCQ6KPIPR2WVhm3orQN3XUZkqbgrjae2DA>
    <xmx:RNCdXpFMfsBKnQsVnkPHvfP4Htz2jMhky4nXsnqlHeq-mT6PGqyJ2A>
Received: from localhost (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F2D63065C30;
        Mon, 20 Apr 2020 12:39:29 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200420083046.GB28749@infradead.org>
Date:   Mon, 20 Apr 2020 09:37:42 -0700
Cc:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <jolsa@kernel.org>,
        <brendan.d.gregg@gmail.com>, <andrii.nakryiko@gmail.com>,
        <ast@kernel.org>
Subject: Re: [RFC] uapi: Convert stat.h #define flags to enums
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Christoph Hellwig" <hch@infradead.org>
Message-Id: <C266KL0CLET8.Z2G09QJ83ZWK@maharaja>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christoph,

On Sun Apr 19, 2020 at 6:30 PM PST, Christoph Hellwig wrote:
> And that breaks every userspace program using ifdef to check if a
> symbolic name has been defined.

How about shadowing #define's? Like for `enum nfnetlink_groups` in
include/uapi/linux/netfilter/nfnetlink.h .

Thanks,
Daniel
