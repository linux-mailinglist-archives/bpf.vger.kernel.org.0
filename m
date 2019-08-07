Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A528496D
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfHGK1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 06:27:10 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:37237 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfHGK1J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 06:27:09 -0400
Received: by mail-vs1-f47.google.com with SMTP id v6so60383765vsq.4
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 03:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gxhYef76glfbTTnTwqPXh5V3ObMrrq3MFddOB3BzO5w=;
        b=HxqU2j7ML4+3DgEfApg1VwNOXsDAXrQscKyTOgmsvHXLiDFJZogelz1QB4aF335z1G
         mC2m/9iYLRiL0RsRZVN9KQ5tBf5xIUKzWhwDse+Tj9Th+7CsTgbSoJeLspaoMA9t3xp/
         XpwZgHQNK6vEvbqX+vHQAXjxYAmTfPXbvumxeqhwXLUtxhVZgThEXqDpO5dX9cei5jnr
         35+zyOJQ8QmJSNP2NqgDv3YUEaujUat4qim9y+9xGsNZbbae0xPoTVnaIPuSDdATlBX9
         SUS5r3iJL5iWTXATLQGNPzFMxKpUvE+g6S/9yd/mMgTL3d/lVCeT3L9KTUWHXHRu9+Uh
         pIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gxhYef76glfbTTnTwqPXh5V3ObMrrq3MFddOB3BzO5w=;
        b=g+uoZ03DweZFN9ethMIW63Zud4Aq8ZaO+dNK9ydEo1SNp1/IIZ+ZESkbRqNQuGyuSR
         AyuxnEtJpcB+Tc4VNF54HkRkcCKb3DEZItwzcr30UQb3JyXEX5C6msYf9i+lRPFjFNzY
         2oNFBbDEpsV+kzj4YQi7vae0jA3mSyNj0xZj8S+l3I9YaTPXNUW18/wX3TIuUBtaiXmC
         7pIFkKHnjWE1uh9Z8npVGzwyA+s3jzXqrUeIwutqik4g4nVQIN0UZp+HBKZgrDWfzKVp
         c2gc5EkgGCtqNnu7nbpLvBrCY6UgRHyj7WatnY1Jo5xegW3NGjpk2lKdrmp3c8gl7CDZ
         Uv4A==
X-Gm-Message-State: APjAAAVxYVQWLf6WaxxA2rDOoO1PUv9ToDibPB7TDCxEBh8G9pqws/hz
        F8RjDMkMMuyIhM5YAdsgkMMkrj0QADNuI+bwUpSyyoKSvpI=
X-Google-Smtp-Source: APXvYqyYhG5j2ho2zQ87dWz74Rfz+iNs/DWHedhOEHEtj0YPUAlIYw8E/VJ0xfLie41TDs8/tuTmgrkPYKnU/HJIY28=
X-Received: by 2002:a67:f998:: with SMTP id b24mr5603461vsq.180.1565173628824;
 Wed, 07 Aug 2019 03:27:08 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?U3phYsOzIMOWcnM=?= <ors.szabo.hu@gmail.com>
Date:   Wed, 7 Aug 2019 12:26:57 +0200
Message-ID: <CAENv5Qs3gzOOBHPV8bNgzee7OGwz_40D3NvjOZcYrYjPjQCv+Q@mail.gmail.com>
Subject: xfrm states with bpf
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
Does the bpf helper function bpf_skb_get_xfrm_state suppose to work
for ipsec using transport mode ? So far i have only managed to get it
working with tunnel mode.

Is there any possibility with bpf to create new SA/SP (transport mode)
on the fly when an ESP packet is received but there is no SA/SP
present for the corresponding SPI, provided that all necessary
information for the creation is available in the bpf program?

/Ors
