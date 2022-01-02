Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A7482C9E
	for <lists+bpf@lfdr.de>; Sun,  2 Jan 2022 21:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiABUCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Jan 2022 15:02:11 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:47289 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABUCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Jan 2022 15:02:11 -0500
Date:   Sun, 02 Jan 2022 20:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641153729;
        bh=H/sfOkIUwbQ7kkNDstHRxWQo+4b5woPs2ooX191Wex4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=jHyTZ5dG3M4hiQ4wmTFa9rYpOjgi99wmvlMdt6WfjRkwCYyoTHpBvMCUpIZrplkvq
         vJmUrsCRfa9bEaKdYmi61+io+mltTh+PyFm/v6rhNccv/BWpSY91E29imF6S6Gf7pI
         kdtKMl8The7Oqgbof/bRUCv69cSYoOwGLwFELHQqXDTchyYI4al8+JbR4QVusnU6Be
         /Nnbl0uvgAz41sFKGefzjoRWLhLsAqjTBLMz+ocAZHtQutksN0JnLn13cLf0TN4xqs
         glYbE7RnDnyVJ1zUfC+JRXUw/w2WcaLH1W+uMsaSdTP+4UAQ/KTsPgJ9P0xn86w//4
         jbw3hHbuaaCyQ==
To:     bpf@vger.kernel.org
From:   Jhonny Knaak de Vargas <jhonny.knaak@protonmail.com>
Reply-To: Jhonny Knaak de Vargas <jhonny.knaak@protonmail.com>
Subject: Some questions about EBPF
Message-ID: <f9526881379a8d5f2c27e2fe5843885d648b31ec.camel@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
Got some quick questions,
Consider that I am a newbie just studying.

1. How can I subscribe to the list? This link seems to not be valid
anymore http://vger.kernel.org/vger-lists.html#bpf

2. What I want to do:
=09My idea is from user space set the pid of a process to the bpf
program on the kernel side.
=09On the kernel side I want to have a variable which will have
that PID that came from user space. Now,I want to identify writes to
memory that process owns.

   Question:
=09I am not sure if I should be looking to use kernel headers for
identifying the memory pages of a process or should I be reading /proc?

=09Can you guys please give me some tips on how to achieve that?

Jhonny

