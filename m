Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61D5AE5F0
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiIFKwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 06:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiIFKw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 06:52:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E547C52A;
        Tue,  6 Sep 2022 03:50:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so7896579wmk.1;
        Tue, 06 Sep 2022 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=b1zh3Myo6jU2fqhvORGPXUCfBSeS9QtYiYf8N35O2G8=;
        b=BCOPqG0yChofOoj0r9oHxKJbYuhNfnuLxdUdm4eBHhojDQ2/p2F6Oe+P1CerRJwt4/
         O1xjMkpEGjCZz6ig+13Jawcyekt2YZ0+PBNDeMisA1Lz40Q6l2dR1skFMlpplAGBKZPk
         V9TIM0nranK9ozI5eVZr8Y2E2xVGDiMpois9P+AZue3xDJhyandWfW0fEeD1pyoxH8z4
         1KQ2cTdqDFBLg+T+C2xDnuVbsbzuib6Ne2tt9Wp2yNYrYhq/AxSw1eDaTEpkJWJ62ztx
         x5qJ5+a0PqG6OS/Lj4bKc1qI1ZoV/58xjjWWB0YTgb5fDqPqGMsAvIyG7+wpH3efHOjP
         ATJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=b1zh3Myo6jU2fqhvORGPXUCfBSeS9QtYiYf8N35O2G8=;
        b=sxHcSffQkcp+6GJH6MSXGIos9IPF6nGLMqlO7i8eyTFDzou0BEOy9EgRoNQbhYyJPl
         y0ClFcIBXm2SPRatKV+roVSuHjxfDRqjc5n3J4j/RyVorVAwq7Fu5RpMGhKCwLbtJyOk
         YlPCcvvP8sWsskGCo/sYhziDg8/8eAKD/VGP7l7Uox8MG3lRJj1HNIDq072hFW1OLiBT
         lDxrEi3nXTPEv/lmCuGzw+ojyXtiD8ZSHM7tSSLi8TwYba1X+WDGVaIr2OKepmMGkUGW
         CCvdK0dsnVQ+JuJWp0hUMS/yDdIiTIfuukjuJ2cu19bwuEToH5k9pyPMxF5TFV/j/KLc
         e/Dg==
X-Gm-Message-State: ACgBeo3d6NU1cPAz5zvek5bAcVJwby/6zW0I5HMR0OPme1s6/FTIZSZ5
        JBX5VbydrlvFRjvURXRiths=
X-Google-Smtp-Source: AA6agR7H+Ae4hheQrM5Be9dOg7JU2kpa1pWsVb2R/E4T4iMLEPoqt6gYIa7fUtYa7zp/8lwVctmsXA==
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id f11-20020a05600c4e8b00b003a5f5bf9c5amr13639171wmq.85.1662461457391;
        Tue, 06 Sep 2022 03:50:57 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id h23-20020a05600c2cb700b003a2f2bb72d5sm25353742wmc.45.2022.09.06.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:50:56 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <875yi5dbpw.fsf@intel.com> (Jani Nikula's message of "Fri, 02 Sep
        2022 18:42:35 +0300")
Date:   Tue, 06 Sep 2022 11:49:25 +0100
Message-ID: <m2czc86ami.fsf@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <20220829091500.24115-3-donald.hunter@gmail.com>
        <875yi5dbpw.fsf@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Mon, 29 Aug 2022, Donald Hunter <donald.hunter@gmail.com> wrote:
>> Extend the libbpf documentation with a table of program types,
>> attach points and ELF section names. This table uses data from
>> program_types.csv which is generated from tools/lib/bpf/libbpf.c
>> during the documentation build.
>
> Oh, would be nice to turn all of these into proper but simple Sphinx
> extensions that take the deps into account in the Sphinx build
> process. And, of course, would be pure python instead of a combo of
> Make, shell, and awk.
>
> That's one of the reasons we chose Sphinx originally, to be able to
> write Sphinx extensions and avoid complicated pipelines.

I could look at this as a followup patch since I would need to learn how
to write Sphinx extensions first. It seems that it will require a new
reST directive, is that right?
