Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310322C7AB4
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgK2Shi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Nov 2020 13:37:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51249 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728318AbgK2Shi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Nov 2020 13:37:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 38FFB5C0085
        for <bpf@vger.kernel.org>; Sun, 29 Nov 2020 13:36:52 -0500 (EST)
Received: from imap3 ([10.202.2.53])
  by compute1.internal (MEProxy); Sun, 29 Nov 2020 13:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ongy.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=jhjS5rNMPLiJBlYzSThVDBA66WDMqJEnowkYS1PXp7o=; b=mFHx17OC
        DUom+0y05Avtoop84iVlBbzvl4XdrjJ9JOEIy2eDTwPIKBaY7sqif4uI2TXlfsQo
        Uk4XrDKjL2nMKIuLBPt3Q6rtzTaJdhgyXc1Y+5NyaGuSjHd+x2pKpBJOEJLiUTNF
        W/9Lui3mR+BqOnekY8oEiR5eMFitzaf7aYNOwn6ErV2YJmkF0AbyqbbQzodORQ/g
        D1nnZaEt6QOo1MhJhw30MwRJE3ZD12bpi4AaoYHzLfjs0GqSleoMUYNVyUYcxUkq
        wqtuJ/yf/h1DSPBc9O+L1zUVqhaQQfbER3kh0UJcN9FeYfvALJ4CNe1MlfuQgx4h
        174ATmdn9npz/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=jhjS5rNMPLiJBlYzSThVDBA66WDMq
        JEnowkYS1PXp7o=; b=S9zu4hUs4+VLktKz89ABCU11rXAgGvaScYGL+8vRYP0cQ
        R2rQDEghnUZsLTrgyL/iqcXQ0kI3Uaj80Kc/kDkeerES2fImO2BmGKwEJW8VD1y2
        Ymyy9IjbmdH9nUWdYTE9G8Gpz0fzTvlCWDlX1j/0FQzjseDg/f3wyWQjV/rPlBOi
        53tI+GV8QEo4mhSaW1KPjgxj8cOoZKsddohWqH7/g5bY10dHSkFl0BNUlcWSNGLz
        lq6SSa8/z3DaU/4ThgGg5RDkM7eFOLQUyJXptzVNMqXYdJoK9al10o7mdVgXh/kT
        rLJjtj5A5D4tLEwOBSvP5SUhV5DbmjRLiXewfo3+A==
X-ME-Sender: <xms:ROrDX4P5xbPDN79BR_RlqFPYcfiN-FRr_Y7tzEyAbHUomPDU5gy3-Q>
    <xme:ROrDX-8KMVCvjP47bpZMQgnl91inCcZhrbPY1MXQhQoRklwqWooGvHq-DWa-IgEaQ
    3po0JPCQvfO61fkTmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdforghrkhhushcuqfhnghihvghrthhhfdcuoegsphhfseho
    nhhghidrnhgvtheqnecuggftrfgrthhtvghrnheptdektddugeevvdefveejheeujeeive
    evieeuuddvgeegvddutdetgefhkeduffdtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghpfhesohhnghihrdhnvght
X-ME-Proxy: <xmx:ROrDX_S5aIKyJjPycqGN6Mm9T46jDJi6y7Ap9KbBp4O0roLo0CHBGA>
    <xmx:ROrDXwvRe-cXd1Tit00mx9q4NhC3YCoXP8LYRs70YBA-kfFtqk92jQ>
    <xmx:ROrDXweo70l04xMTIEECNzgPP_psSA5KCYWSjhMeUuD745H6G5ijpQ>
    <xmx:ROrDX6rxvBsDRtuHg3nA8x0MVFq-HrixvYv6BzUJ4288eddyX5_p2w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1869F4E05C5; Sun, 29 Nov 2020 13:36:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <eea9673f-5ee4-4adc-bc64-fcc88f715cc8@www.fastmail.com>
Date:   Sun, 29 Nov 2020 19:34:14 +0100
From:   "Markus Ongyerth" <bpf@ongy.net>
To:     bpf@vger.kernel.org
Subject: HELP: bpf_probe_user_write for registers
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I've been looking into introspecting and possibly convincing an application to behave slightly different with bpf measures.

I found `bpf_probe_user_write` but as far as I can tell, that only works for memory areas. 
Is there an alternative that can be used on registers as well?

Thanks,
ongy
