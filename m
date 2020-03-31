Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0906B199B2C
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgCaQRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 12:17:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34882 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaQRH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 12:17:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so25871579edj.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gX2hE+HplrSkjQMDyoGhUaYt4zWQ23hFC2B0NDhOvdU=;
        b=IBPI6C030cTlbHelR/XZYCDNafNBIleAyBMfz3XM84QvRLqCT1af5qo2fZtQupL1om
         JPhd9S1xt9P9xZGjPrU+z6PTsfP704fD+ejPhGG+KgEjqAYXTB0tRyjln/P6k9RSORJ3
         eFkSgj1/VRnz/HABtwVep55D5AzfktHOSZtqvG/UyT2d1YuiTaSgwQqpIVfgo/i2Czs+
         JWgH2UhMJo/aYV95S6GXI1e9EAmPrQUyRSoIs+Brya93lnRHXQo1jRgTD4yjMe5BQowa
         ImJhGvWdUnakAMwkuveXRdRI292XhlK5Zejc3YZLMlDI+eh38/DhkbAUYo6yQ9pOa8rC
         690g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gX2hE+HplrSkjQMDyoGhUaYt4zWQ23hFC2B0NDhOvdU=;
        b=gwDZHjH7yai1ym24RxurrHD/vpN48cR4nD8/y3tU4dANGP6De3xEjWcweZqBHAbXv2
         CfzO07ljObeMXqNXtLPEfmgWY/v0l8w5CvHPYDBbCJM/UJ3V+gwDP8GBlX4f0v5oj3hW
         gbctknCI1YGkDfTKbcIjZffZjMg1HO1OVwsfHvJS10xMKVmfMmWF73Qmeo7Rue718QYP
         YviatykKsHBcqJJiBVa/f3r+bzvjIxJ1irTtvlP7gD0WDUPcVyzA67v4M8+qWmvG3QnK
         njlFWEHlXJRpsz8VyvM70njykr9dmECurOzrh04jm/NDWdA0wSWtouKDILZ6EBY89vn8
         yL8w==
X-Gm-Message-State: ANhLgQ0jlyLMR72Ao+QUBOZajvAXcXY+9lhzBy/do2pWh+cT0z5+4eue
        7XYikgCdJf8fD6rkHGrupuJstT+EAVS1sNC74rquBffNr+o=
X-Google-Smtp-Source: ADFU+vuYMSaSDaKrkDsjggDgWgtURpyHPz0pHuStfoZ+07sdPSCzavR0IO/HHm5jQtcVlioknisoH4nPJSQh+geIQeI=
X-Received: by 2002:a17:906:7383:: with SMTP id f3mr15713743ejl.197.1585671424950;
 Tue, 31 Mar 2020 09:17:04 -0700 (PDT)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Tue, 31 Mar 2020 19:16:28 +0300
Message-ID: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
Subject: probe_write_common_error
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When I try to probe_write_common into a writable location (e.g a
memory address on a usermode stack) which is not yet mapped or mapped
as read only to the memory, the function sometimes return a EFAULT
(bad address) error. This is happening since the pagefault handler was
disabled and thus this memory location won't be mapped when the
function tries to write into it, an error will be returned and no data
will be written.
Is that behavior intended? Did you want those functions to have as
less side-effects are possible?
