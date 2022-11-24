Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784E63764E
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKXKZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKXKZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 05:25:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75223D
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 02:25:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c140so1322852ybf.11
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 02:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdEfUzRWM9zCDmvuvXx4d6JWvtaKJZa/eDQXVxPlVEg=;
        b=Ynhf3Yk4ALnQCe60l6wcsDjuuQJeYnvU2nt7BtJh+qYOpjLyx+QdrFWmP8aEmklolR
         13Fc8muNrHdzac6BpTOBlN6kBq6xfsxKQEd3viI2gYIzkBP3pEk80ctZ2uCQk4uwKAUd
         HA4TeQXfpulPQWTBVj0EJSRPNBqTiKM/SyHvV6foAXrLewYOS1LljBF3xoKkIIZBztgR
         hRryeOjZkK9XTelHeW7Q0PaWBXIUYY46vjaeDsRqHX9DQRFG6CEoJ87n8elYNLbkQp57
         4sXKZQxHbvTLH0vcE6D/1Q8O3gmNLJOZciIXatpgKmVJLj9Snnvw8UICJKsdTfuOfTeJ
         0cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdEfUzRWM9zCDmvuvXx4d6JWvtaKJZa/eDQXVxPlVEg=;
        b=BDSRy854cjS6kDEEZZthPNvq3DM+U33kKtbpLEYzK8WBhvnKxEGBthkR9sgopHHEbT
         9cxRKDL+KQUSaFlEnwOeKLgkrOlnOTh6P01XRmgIXWhquOi0gBiBaZ+bOEYT+qgIZHUD
         cP8b5excFxwjABZArmGRnUsqlj/NZcmBJgQjhY5d1iTZnPEbWeNXkxMd/TMZ2wAfGE5L
         2LaUipxf9SMPmigpFI2MBVwC7ZYuxcCeRSlt48Vb7JJZGIE0MsEuy1BcM4Fsph9FfqXZ
         yZ2ASGAoLMYKOlvsb5F4iGztjatU8x2Rsxjy3MDZqaQmfj++Mzb7WGWsCbYG9Z0zLmkX
         MgbQ==
X-Gm-Message-State: ANoB5pkjfoj++4PoDXWkJfW3byX6l3vHVmMoKMjcga+Kjh5Ggsi2QrF4
        pLrxUt/cKQ0dzSmxV5WSo1GkXX7Okc5z7axzZ0SsoTpECe7R9vtT
X-Google-Smtp-Source: AA0mqf6JAw/33MFOl/ZEH+ydwU7uaDghZTi9MsH020LlDaCFn9n9nb3JU2xMSj7MElR3Nogt7kuN3DLZqbk5u70hz+8=
X-Received: by 2002:a05:6902:128f:b0:6dd:329f:cf1 with SMTP id
 i15-20020a056902128f00b006dd329f0cf1mr11515560ybu.22.1669285521520; Thu, 24
 Nov 2022 02:25:21 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Thu, 24 Nov 2022 10:25:10 +0000
Message-ID: <CAC=wTOgzZRjZ8zK6uV3u-HqG5WmBtgNWyc62HA7ns96_=6YHKQ@mail.gmail.com>
Subject: xdp/bpf application getting unexpected ENOTSOCK
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am writing a bpf/xdp example which I hope to put in
xdp-project/bpf-examples when it is done. But I am finding that I get
an unexpected ENOTSOCK return code from a bpf_map_update_elem function
call. My test case is here
https://github.com/tjcw/bpf-examples/tree/tjcw-integration-0.3/AF_XDP-filter
; see its README.md for what it does.

I have a matching test case here
https://github.com/tjcw/xdp-tutorial/tree/master/ebpf-filter which
works normally.

The problem may be a diffent libbpf level; the AF_XDP_filter version
of the test case is running with libbpf set up by "git submodule
update --init", where the ebpf-filter version has libbpf set up by the
'bleeding edge' libbpf being checked out at ~tjcw/workspace. I will
try again with more careful version control.

The last few lines written by the test case are
libbpf: elf: skipping unrecognized data section(7) xdp_metadata
libbpf: elf: skipping unrecognized data section(7) xdp_metadata
xsk_socket__create_shared_named_prog returns 0
bpf_map_update_elem(9,0x7ffcaea02670,0x7ffcaea02674,0)
bpf_map_update_elem returns -88
ERROR: Cannot set up socket 0
ERROR: Can't setup AF_XDP sockets "Socket operation on non-socket"

the full log of the test case is available here
https://github.com/libbpf/libbpf/issues/630

Thanks for any light you can throw on the issue !

Chris Ward, IBM
