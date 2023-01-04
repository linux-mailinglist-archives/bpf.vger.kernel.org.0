Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFACC65CDE4
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjADHxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 02:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADHw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 02:52:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C6F6F
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 23:52:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o2so29835487pjh.4
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 23:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgsU3TKYj1ea+xyRd1YeQ6QbaDveXYDp3sPPYkvfdzA=;
        b=X3wlSK3mECwh16qnKQYIBEBJ7WwOizWPqmXryx+DRVo85/0ZsTgqsDZR7/hN2NO7pu
         csytyJLiK/4UpBP9o5k6uLjSVPxOmTejZY/eyTV3nBhT1gxRRFCYGgvZEMH4YJTsT69y
         1MwWEe0Q5VB4/ix++6S8zurF8LLElDo4ppw4Rbv37zVkxo0UL3rjwkeQ+GyHQ4E/PiW8
         J5N8+0Qk5A/1+jC3yjjgj4lQ0UNITHh93ZE/Dmb/VBqJRl3VWC0Kyz6wiBko9Wb2aEz8
         g60wh4tN2TSxUHj08JNDtIUZknkVJy16eldKyXGdi+mwNlGTDV8wdfU03fbJ6gW6lf7O
         D4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgsU3TKYj1ea+xyRd1YeQ6QbaDveXYDp3sPPYkvfdzA=;
        b=2W6SyfUMBZXyfd3Jk/V6Bni/Xov3ByDtn5lZv5punhVShSkGioH00QLDo4bxYrMOCb
         r7rc2Ofjkpr5B+8/FXafWYXMmE5nHugkG9zvUpiKrgoO6yQp77r6/w+6J6/RlDbmFGu+
         cfjT7QuZltkw5ZyrwPIqW96mTdcQnFYqYUUVm3OIDyM30bzJr0HCknqnOc28kBG7e+U3
         k7aXbDinVQA2z9WPftnm4U1X8KxBn7CSBwB3Tu9rXuVW2wGcd1ZLvcCWDwZCO6l4unhR
         JBxyPnNJY0CAtuuhackBsU7PaZNpXx/dkXchiEGLRVq6/2IoixRvegtVGvKHC6Q55n6L
         glzw==
X-Gm-Message-State: AFqh2kqfwNFNPVmYtFsv7Q5NMhF3LTj7l6BBPWYGLrbf0+JQNx5C+09b
        7We4ez3uq8yG55TSoNU4gWq2szlDGTtH7jAXlzE=
X-Google-Smtp-Source: AMrXdXuGlXHVU5jXWmAFBqNIdpTPtP2B9Lm+POK5RbtdJ298jNbAOpo+b+H+agURxEiGLWsFjpHRGFCC6Clixx4U2Eo=
X-Received: by 2002:a17:90a:638b:b0:221:52e3:1f56 with SMTP id
 f11-20020a17090a638b00b0022152e31f56mr3605687pjj.225.1672818777356; Tue, 03
 Jan 2023 23:52:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a4cd:b0:367:4897:b131 with HTTP; Tue, 3 Jan 2023
 23:52:56 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <gd134517@gmail.com>
Date:   Wed, 4 Jan 2023 07:52:56 +0000
Message-ID: <CADYS8vB662jATBi-Bm9C6YKV-re+dxfb189Cb0nvUJjEJ0+Nfw@mail.gmail.com>
Subject: Happy new year,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Happy new year,


This will remind you again that I have not yet received your reply to
my last message to you.
