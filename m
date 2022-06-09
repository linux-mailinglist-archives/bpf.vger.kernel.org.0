Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9C545091
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbiFIPUJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Jun 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiFIPUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 11:20:08 -0400
Received: from lxc-smtp2.ens-lyon.fr (lxc-smtp2.ens-lyon.fr [140.77.167.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2622B20F6B
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 08:20:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lxc-smtp2.ens-lyon.fr (Postfix) with ESMTP id 8604EE5031
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 17:20:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at ens-lyon.fr
Received: from lxc-smtp2.ens-lyon.fr ([127.0.0.1])
        by localhost (lxc-smtp2.ens-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O5TeaPae1iFs for <bpf@vger.kernel.org>;
        Thu,  9 Jun 2022 17:20:07 +0200 (CEST)
Received: from smtpclient.apple (dhcp-13-99.lip.ens-lyon.fr [140.77.13.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by lxc-smtp2.ens-lyon.fr (Postfix) with ESMTPSA id 7C990E4E26
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 17:20:07 +0200 (CEST)
From:   =?utf-8?Q?Th=C3=A9ophile_Dubuc?= <theophile.dubuc@ens-lyon.fr>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: vmlinux.h conflicts with bpf.h
Message-Id: <598AFF44-37E1-49B3-BEF6-ECC5743F4CCF@ens-lyon.fr>
Date:   Thu, 9 Jun 2022 17:20:07 +0200
To:     bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I get errors when compiling my bpf application, because vmlinux.h seems to conflict with bpf.h. 
If I include <bpf/bpf.h> or <bpf/libbpf.h>, I get tons of errors like

>    In file included from .output/bpf/libbpf.h:18:                                                                                                                 
>    ../libbpf/include/uapi/linux/bpf.h:54:2: error: redefinition of enumerator 'BPF_REG_0'                                                                        
>            BPF_REG_0 = 0,                                                                                                                                         
>            ^                                                                                                                                                      
>    ../vmlinux/vmlinux.h:31938:2: note: previous definition is here                                                                                                
>            BPF_REG_0 = 0,                                                                                                                                         
>            ^                                   



What I'm trying to do is use the function `bpf_map_get_next_key` to find an entry in a hash table, and that function is defined in bpf.h. 
I also tried using the `bpf_map__get_next_key` function from libbpf.h instead, but libbpf.h includes bpf.h so I get the conflicts anyway.

I generated vmlinux.h using the `gen_vm_linux_h.sh` script from libbpf-bootstrap/tools, and my Makefile is also the one from the bootstrap example.



I feel like I am missing something but I can't figure it out (I am quite new to bpf) even by looking in this mailing list archive.
If you have any idea of what's wrong, please let me know.



Best regards,

Théophile
