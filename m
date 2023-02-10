Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E10691C66
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 11:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBJKLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 05:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBJKLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 05:11:38 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9404ECD
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 02:11:38 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m1so5129212vst.7
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676023897;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=WsRYNrjRLIAQaiSvAOVqtin6xNsx211jAJnYZlry4eL6WjQ5H+wEjkh4XN77TvhNs/
         U7sfhqQD8W1lh985A9C1Xg6p+HsbmUeuu5sxNh2cX1EximyvqmBsIAE4EYIkCkTgaJ1m
         1zUrGTPF12zKSC9eWW+8UH0AiZUzHlAhGgfaJiJxb5HsY4N3RSwTWhkOy/7DYonzshGQ
         SKJYCYq9eCAoVusmVBKGEE3asSEq+zd1Ou3OAD2wwiMI/HdNso5T8C0BybIIAkjwOqwu
         f2DcdwDaDDgL2HaxI1z0yKGwJYD2VCP8rA7EdrEPQ+9NR3WwFaTaoalHRRiGgpPjCldC
         dm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676023897;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=kmm4PBaYHhqCn5Y0em+yBXvZBfFwswXYgxscZha/eChZT2bPnOZ6CUv0zYtGJsGgk0
         lgQX3BbwmnKh4PCwiE3vQxxAqMAM6V46ao+RTDpi8zh6MwputbNl9iHNbXMQLnAF4al/
         qh30R6o8kPHZSZN+xc2mzzxLuiECxkn8hYFRNBwtgvU2PJJqH2LFEoNBclgkzb9k4mGv
         9uwwWQ4Q+n7EwgCJvpIVAI+Z1g+ymDYx5lfDhwokScyGIFmcoLukHJFL3HXwoOuOVWJE
         Elpw1Dzn6X5fNDmvfVUbs8y66lAB2QPi2XtQMKwMaE2F3jzwjvafxUFsiqKXYA0izGQJ
         tZiw==
X-Gm-Message-State: AO0yUKX5yiqJOogvutwNIHi4lENY1ffdWvGgAUpDq5xhiD9k+UoqLWlV
        pp8ZIEWJXT9xn17SJH7kpcTvpGckx+gpuj3fVlQ=
X-Google-Smtp-Source: AK7set8NAK7/n03t9WeAJlrazphq8uH9Ko1XcDATlPDOCaX+VlMgARO9tCafaNh9lfOW/CmXy8aPoA9ORGFCaw63gvY=
X-Received: by 2002:a67:e186:0:b0:3f7:528b:d25f with SMTP id
 e6-20020a67e186000000b003f7528bd25fmr3259889vsl.9.1676023897007; Fri, 10 Feb
 2023 02:11:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:1696:0:0:0:0:0 with HTTP; Fri, 10 Feb 2023 02:11:36
 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracydr873@gmail.com>
Date:   Fri, 10 Feb 2023 02:11:36 -0800
Message-ID: <CAARq6VZD46bgdpYzTBMoE1kMedwPnFdKVaa6UBGntZ0HLe2VaA@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracydr873[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracydr873[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
