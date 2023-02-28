Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28D6A53D5
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 08:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjB1Hpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 02:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjB1Hpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 02:45:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27FE20056;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p20so8289085plw.13;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677570331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3IIbCz5VoootLT5YWGDuEjPpnKLu/63h0xoAFiVcZk=;
        b=V8+YN3Jv29gr7RpoaOjzqtnM5GPq+Mx2cPWj6NKepht54VPpr0K/0LFOSLv6Oay9Bh
         leyqNrY2lmQ3MVRdTD0xu2gEGICqXwNSbmaoJLiPFxEZoPQzDO1KS4ADF6qJ1dEVE18Q
         K0bNPYWQIW3L3tYz9QsORMuu9RcYOzxJ0Be3U3LYSDqwQnIJ+FK4BUMeWXw4Am1P9i2s
         94PexP+QZHWL8qaGk5jP2+YJw2DDxKVW6miOXXSaW0IAkthrta/+ajTfQfgTlvMrH422
         rKi/AtUtF2R56vW7mkQYB34zcWBt/VOXelMW5BHbzfke5OnHdEAGeCKOBBQkWtyMxeUF
         cLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3IIbCz5VoootLT5YWGDuEjPpnKLu/63h0xoAFiVcZk=;
        b=viGHcR5JJ+RnT1dElqOrIi7icgeACi1sNl7ujXki5zMKxDBppDH6/od5ZiUkNvXDZg
         FBg2Ju3Us7bzs/ZXpu0nMQ0uQD2d3k6SV6ZJs6nKaOoL4kDnIf3vyiHWysvTT6WEdS2f
         jpN5yQ8N1XTh/YEfbogXguXjqxgufePRzMFAmIB4QCg0BnEC6mGWBWB4NXQnHREGbyst
         ejw5DUSZJezG7Bd80FnTEi2f8snXgh2Prj2EyP5xY2tk64jRMMKbjjcGPoM93Ww83N5U
         8gcrAZNf1rGmPQBC6Vz/L38kbCpOVn+o8wynD9vTcmGlBZJwKqvY+zgSQVlPNf5DRo7o
         4RQA==
X-Gm-Message-State: AO0yUKW79iSxe490eg/km37IkyTU3yC/VkI50l1HfKomRvMw0LGex4Gx
        CvgPZbxeo8+BmBfBxEa3VEs=
X-Google-Smtp-Source: AK7set9Eh7VgsYyp2ljJmYCIFQfKilCRuaHIthXT3jOHBTGuVlc0afsxJQLt52+1Lde4Az2sBKlsAA==
X-Received: by 2002:a17:902:d507:b0:19a:96ea:3850 with SMTP id b7-20020a170902d50700b0019a96ea3850mr2547931plg.17.1677570331254;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d70d00b0019aeddce6casm5773361ply.205.2023.02.27.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:45:30 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id ED4FE106642; Tue, 28 Feb 2023 14:45:25 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] Hyperlink fixes for BPF QA documentation
Date:   Tue, 28 Feb 2023 14:45:21 +0700
Message-Id: <20230228074523.11493-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=bagasdotme@gmail.com; h=from:subject; bh=us+PmiUeFdZVNAJDwt3UjWoGL9oA6EGBTOm77WeDDAM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl/N3ILKSw4Hdc+Z/uUIyI+lTOyZeNUeHfHzHAQCp1suvzp 2//nOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRP2aMDL06x6pNNwlO8Z1vFm/P5G 4u0FmxSS5iflyjtoisa5hbEyPDqxRl/63OzY80TtZeqHI8voVfeL/NnuK9YR2Hel4HX+LhAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the broken link fix for Documentation/bpf/bpf_devel_QA.rst was
applied, Daniel Borkmann asked me to also fix some other links in the
documentation [1]. So here is the series.

The fixes in the shortlog below should be self-explanatory.

[1]: https://lore.kernel.org/linux-doc/7cd545a2-4a5c-1961-1cf7-cd0f24e41df8@iogearbox.net/

Bagas Sanjaya (2):
  Documentation: bpf: Do not link to docs.kernel.org for kselftest link
  Documentation: bpf: Link to submitting-patches.rst for general patch
    submission info

 Documentation/bpf/bpf_devel_QA.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)


base-commit: 2d311f480b52eeb2e1fd432d64b78d82952c3808
-- 
An old man doll... just what I always wanted! - Clara

