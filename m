Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA2679D8A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjAXPc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjAXPcz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:32:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6199022
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:32:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y19so18690622edc.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=ejwbKf5nIcDvCxVWOlKdzy25G+cIAjtdeD//X89dTwCjY5lJsT7fLG5zZAtTfVD/42
         rrfFswQJaFGPZCo8OSnsFPjdjc6Cip2lwl0sSw6dMvYoeJIJAb3cxtazNsFnjkYrFVuB
         PYA/upAMGp+XAafCivgnYYJ279LQ6HuwF4CJNn2DkGfakq/XS6zQ0UZUqGh0eialmC1S
         GAI8lS7P00vLm65sw/2hHKfoCwxqpI4/f3m/0jQYbXl0T2qpJEhQX9sLydrvDP/TZENI
         m85iLE3yDD9zTfMnR2VrkC6uDAdUIXtWqqfpFJ8IlNqKuaHPP2cl9H66MSqmmpyidV/9
         Re0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=F/mWTQVSl0sNTF4I6Pa4JAJnaXcjbHDDoQVwZEpAO+DaSNJiz2ol3e4y+IeuYN0TdO
         qsd926pLtlcqW62SmUNEKJGQ/xJ4qSDkGoFQbw4q9xpOGutUVpGR49le3dcZF2nAvOKF
         QLKivnRVVoSwabtn3i224cNjfnnbZ9sLLYXQ0JsWqJ2hhcvEzcyWcwLM+X/95xfS8x9l
         n/50whCSgx6pmVy553hYu3v9oTz6KvDWOgxS27iAK6qdpmTmlFsX9HAP+rk/KdQC5wiV
         tBre7r57mHifTvoz2FLcYTARXCP0BRaUqGPg1HUKPPcwZGR3j325qhA51mHujgz/HYcQ
         KpxA==
X-Gm-Message-State: AFqh2krYQlaFcCMwG2DXuUMke4EldROwn+7vEMeHomC7EO5JLCLPqN/x
        4i5apEJPdaKMltDpRmT7ZzUQwhQjkgBpdj97Nh8=
X-Google-Smtp-Source: AMrXdXuQwVmd1VRv/HQ/ipPewE8tgt1PRjyyqpy+oaBg/uBZ3ucBLjZbHXTO5n/j58m+GSnSkgiFxLKQH7AVHaHJ1oU=
X-Received: by 2002:aa7:dd09:0:b0:49e:ee42:9b with SMTP id i9-20020aa7dd09000000b0049eee42009bmr2039082edv.74.1674574369924;
 Tue, 24 Jan 2023 07:32:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:960c:b0:86e:f59e:9cb7 with HTTP; Tue, 24 Jan 2023
 07:32:49 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <maryamm77775qqqq@gmail.com>
Date:   Tue, 24 Jan 2023 15:32:49 +0000
Message-ID: <CAFKE0mAGqwZRsWzEFh4z-WGq_uJv3hVXLAMLt+Vwm2-inqVmfw@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maryamm77775qqqq[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
