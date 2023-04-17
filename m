Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6786E4F8C
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDQRp7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDQRp5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 13:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A6AF02;
        Mon, 17 Apr 2023 10:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEBE625A0;
        Mon, 17 Apr 2023 17:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6730EC433D2;
        Mon, 17 Apr 2023 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681753533;
        bh=CgLBqaVVYDTDfk47l9m6BmnvKUV8hYvGLwTIwfJY6PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeYSpqjZG/7xt+jCEpATJpt+7NFubwB45iwlxev9JhXb1mZMLPqiSP9mv+4shvJuq
         SbNnsWwhsggsVpfklZosWhpgRinKe54pe37JIvfPB5Snngegfwo9iJA+IrRWigp+wY
         JXCgn7qbR9wPR143JwdMxAJ/DZJDnClbCcuiDwlI=
Date:   Mon, 17 Apr 2023 19:45:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5a6L6ZSQ?= <songrui.771@bytedance.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] libbpf: correct the macro KERNEL_VERSION
 for old kernel
Message-ID: <2023041729-luckiness-active-3ddb@gregkh>
References: <20230417084449.99848-1-songrui.771@bytedance.com>
 <ZD09abW0YyHU3Snt@kroah.com>
 <CAAz4JzJQNC56t+Yot_0+im0Eop1QLQJNZU8SGUxDsgXiX1RapQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAz4JzJQNC56t+Yot_0+im0Eop1QLQJNZU8SGUxDsgXiX1RapQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 06:44:34AM -0700, 宋锐 wrote:

<snip>

You responded in html, which is dropped by the mailing lists.  Please
fix your email client up to not do so and we can continue the
conversation.  The kernel Documentation/ directory has a file explaining
how to fix your email client if you have questions about this.

thanks,

greg k-h
