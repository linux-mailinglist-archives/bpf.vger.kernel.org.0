Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25F5B7E26
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 03:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiINBOG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiINBOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 21:14:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51411C0F
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 18:14:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f20so15515839edf.6
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=qqC+x931rp3NZVgMNWrfjIgYAWjpa8UBv5Qch6rL0pE=;
        b=Al/HZ8F8Zw8kpMXQbFHoghMZ7u3fpClXwLgdm+xeALQXKOZGjtTYACmnppSCE1AxHe
         8MoLd6p/saTbIJIlE96v1rOgS5qYEjvAAf70v/VDi83cSzH6GPHrCYPukmygEHAnQP+R
         R8FaiXV8HiPlVaa8ICJdGZ7x211p7Qs4fXqhmAVK+Ny8kmUgNc2idI2w9knN1Dzd5Lj+
         jCFteps6pyS0ttzr88Io2aaCSK4wTrQyzcV5UtuONsCJ8PKWPoWzQpErIbNCMgvm472y
         IvKEYLb7EswQTdZFfuiUEDvPxoY5ao7Pm4LId9FS4zPSgJYc3brcNZIqLEOSp/5hLQrq
         SEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qqC+x931rp3NZVgMNWrfjIgYAWjpa8UBv5Qch6rL0pE=;
        b=H2eq3rGcKruTLyRAKo0iemWhnwcLB2vXnES8l5L1IM+MtK3TylvXfUK/lshGjBv90L
         fnqk60ITI7I03NtgBEbTxu0i+nE4UiNTy12mAeILZmj14nEmDqZSPOM8pjFEamks5o8f
         6NSLLJzoFIlHvS/DuwQsKvMHI4PU2aZZ8TmJK1mEgGcseLgNWitatlw7PKvI4pwrlNFw
         k+FKRsCyRPmZS0Ut041BP2GY6JS/VGb5Qh1X26CcZfINE1Tm88eHEZ1O4PJ/8x/0p8PM
         YNhF5q4gq2W3W6f/ARz+cb1CpEx6IR4zF3NNmJj12WVWN9knTbxbibh1RFTWkHN9ZPqm
         PlSA==
X-Gm-Message-State: ACgBeo0sAPGDoYhPWGA5QbjV1vSKGVi+8uUhz49r0ekngQ1PzVOnPUVf
        kmJqehImLRYSmpQd2yuZ2coMLNhmMqTAoQ/n52M14Vk8nESMsQ==
X-Google-Smtp-Source: AA6agR4SE6gPC53wjcYK8BCfBLgP7KxcntM2FJPwhtNMS1DKLbIvDnq3UPSxPOO2pdp35D4ZzKVzbgMGRs7/X2OqJLw=
X-Received: by 2002:aa7:c7d3:0:b0:44f:2776:31b with SMTP id
 o19-20020aa7c7d3000000b0044f2776031bmr27166617eds.251.1663118042564; Tue, 13
 Sep 2022 18:14:02 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 13 Sep 2022 21:13:51 -0400
Message-ID: <CAO658oWgicsACo3DUripSBkU6_bjJCScMUHKqLww7O+xY8CiUw@mail.gmail.com>
Subject: Interesting data corruption in bpf_object_open_opts
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all, I'm experiencing an issue that I want to discuss, though I'm
not sure libbpf code is at fault. Any guidance is much appreciated.

The behavior I'm seeing is that I have a `struct bpf_object_open_opts`
where I properly set each of the `btf_custom_path` and `kconfig`
fields. I then call `bpf_object__open_mem` with this opts struct and
get this error:

libbpf: failed to get EHDR from /proc/config.gz

The very important thing to note here is that I'm setting the fields
and calling bpf_object__open_mem from Go code using CGO (this is in
libbpfgo). I do believe it's likely to be a CGO issue and not libbpf
itself, but here's why:

I've `git bisect`'ed the issue to be caused by commit `d8454ba8`,
which leads me to believe that CGO is failing to adjust offsets for
whatever having `long :0` in bpf_object_open_opts does. I can't figure
out why this was added, what exactly does that do? Is it some type of
added padding? Is it possible this isn't CGO?

Thanks for any help,
Grant
