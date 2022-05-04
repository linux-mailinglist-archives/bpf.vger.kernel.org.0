Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C151B471
	for <lists+bpf@lfdr.de>; Thu,  5 May 2022 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiEEAFN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 May 2022 20:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352325AbiEDXyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 May 2022 19:54:00 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E315A0E
        for <bpf@vger.kernel.org>; Wed,  4 May 2022 16:50:22 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-e2fa360f6dso2799267fac.2
        for <bpf@vger.kernel.org>; Wed, 04 May 2022 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=YEwNer+zbOytdPczGSjCWUpruq3dWGV+AT1+vSvQZM3wLk8F6agUMIoiRFtI8JuOif
         3cj/FssKZ763tQMle6QbmikQ6w3kh8HjwHGbGXvmdu0jxycrgUb+Rx2aaovTqzStpv6a
         5NpmZ28LXyOm6MTO3YoBfN9usFKafzrAkGNnCYUVTLGBkW7vwki9H0sv1RgL0vqYaUcV
         PSmTUdfzGx++9fjWvg8qHPTtK/H0/uVv6vMK9EmUotLfjiGVhiOoWghjKVUayLpwzZMg
         p+JkaGXYDhc5DtHEuzvHk+VQc3GGBbUfDJ8GzuYg7EZYWb4UDSMTwB+cgSok6+foGz/8
         klmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ampHH5WJLIBWSsxWwzVjbk5pO9UBFxn81pZ6QIDzZtY=;
        b=MK5SnJIKTp1EgckPiIfTwgkcDxjum5KZUJwN7nA5W76u22/JVTZ2v5GWjs1Y+yLio3
         EMP22M6O0dA9jfHu+3NtZXTTK45lBfuhxjj9miqbaBLzLvjFFpiET+O5sw53vV7Yl/Zq
         wJWvDsigwMboq3WQu1fsf94SCbjHSSxN4H0DGsgjKZftkq1DnLctaUVgKy5jWIxzXcJc
         VleLPD8dJCEAgRocs8nDVFQ0uwn6AJwzzZplGW5Ogo35APnW5a+K8uIs1a/V7Oswd0Pj
         v1m9IeqJqayhH9PXLvbnZ0iGJRESoxcJ+tql3CRPNJAeHq4UijHutquq7QUXBoo2zoAF
         +heA==
X-Gm-Message-State: AOAM532c7TkrlbK82hetWBv9gIVj50OeozIgbSASAmg1kQYH4n27if1z
        gnJtyZhR02LCNIetQzDe9dYVm7WJrZlNCNF1bJa4VLmBOaP4bg==
X-Google-Smtp-Source: ABdhPJx7IBOxhDL7n8H2JjP8pWv8vaa/M3v/hCII4VltZvlf6mQzcUfLxf0CFddLvz6bEtRCB2lG1x+Sk3XgGfltZ58=
X-Received: by 2002:a05:6871:453:b0:ed:d2f8:8ecc with SMTP id
 e19-20020a056871045300b000edd2f88eccmr1020666oag.228.1651708221699; Wed, 04
 May 2022 16:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1a9:0:0:0:0 with HTTP; Wed, 4 May 2022 16:50:21
 -0700 (PDT)
Reply-To: ortegainvestmmentforrealinvest@gmail.com
From:   Info <joybhector64@gmail.com>
Date:   Thu, 5 May 2022 05:20:21 +0530
Message-ID: <CAP7KLYjEvQy1NFXFAsF7L852zjDQ2sTySHZJ=cnA1gAffqJZfw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joybhector64[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joybhector64[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
I am an investor. I came from the USA and I have many investments all
over the world.

I want you to partner with me to invest in your country I am into many
investment such as real Estate or buying of properties i can also
invest money in any of existing business with equity royalty or by %
percentage so on,
Warm regards
