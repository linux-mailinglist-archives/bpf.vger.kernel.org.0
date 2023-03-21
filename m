Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D806C3DB4
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 23:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCUW0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUW0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 18:26:15 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7C570B4
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=amj/cY5Bd4KpaGirGywKy4Xv735jwOwUujTU15ug2Mk=; b=EClpkbZYIBvSMEUst3IyLdgjNl
        qoiqBkHNy4SpQfygdXeE+73IXRSoBWuSweFsF90M5L2O6TekRAXi5mldVqReoqYGaSl8OKbsa7igy
        FG+BqTTOouB9SZ9UnPnmyIjpLNHTlZ4FAgJoFP7xuLnAkp1qiONMS+1B0yKt0ya0YHyQlj0RhoIdD
        z06aBxVqMLOhQifrACZ19tUwyWlGhOqvhSPuG/akXbrOOCYfaS4XFVEDcHIt2XwLqmhk52DjhUtIu
        klO7s0LR7enUHfeWNYWS76qqyrrRa/cS/eHO3d0Rojo8JKGAUGKWMB9K1Be1IuIhk87zvYJEta3iR
        1KPBzYcw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pekQk-00086N-2w; Tue, 21 Mar 2023 23:26:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pekQj-000XBt-Tg; Tue, 21 Mar 2023 23:26:09 +0100
Subject: [stable] seccomp: Move copy_seccomp() to no failure path.
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     bpf@vger.kernel.org, lefteris.alexakis@kpn.com, sh@synk.net
References: <20230320143725.8394-1-daniel@iogearbox.net>
 <20230321170925.74358-1-kuniyu@amazon.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2a09e672-5cc4-346d-2536-5efa5a59bae1@iogearbox.net>
Date:   Tue, 21 Mar 2023 23:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230321170925.74358-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26850/Tue Mar 21 08:22:52 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kuniyuki,

On 3/21/23 6:09 PM, Kuniyuki Iwashima wrote:
[...]
>> Link: https://github.com/awslabs/amazon-eks-ami/issues/1179
>> Link: https://github.com/awslabs/amazon-eks-ami/issues/1219
> 
> I'm investigating these issues with EKS folks.  On the issue 1179, the
> customer was using our 5.4 kernel, and on 1219, 5.10 kernel.
> 
> Then, I found my memleak fix commit a1140cb215fa ("seccomp: Move
> copy_seccomp() to no failure path.") was not backported to upstream 5.10
> stable trees.  We'll test if the issue can be reproduced with/without
> the fix.

Good to know that 5.10 EKS kernel is based on top of stable one. It indeed
looks like this could be happening there given a1140cb215fa is missing. I
wonder given it has proper Fixes tag why it didn't made it into stable tree
already. Thanks for checking, if it confirms, then lets ping Greg to cherry-
pick.

> Anyway, I'll backport this patch to our all trees.

Sounds good, thanks!
Daniel
