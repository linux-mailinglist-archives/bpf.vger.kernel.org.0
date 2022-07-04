Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640845652EA
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiGDLAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGDLAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 07:00:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B866AFD35;
        Mon,  4 Jul 2022 04:00:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n4so5537773wru.11;
        Mon, 04 Jul 2022 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:message-id:references
         :user-agent:mime-version;
        bh=r9fNXfRbdc5ZvafBNWErX1+dlYsQ8FGynZjrFEqrCDQ=;
        b=koOZfNAI6ls9HxqrNk434Buyi99oDW4VmsitHN2ksndpIv7RD0r/YfluDefsYGrvbD
         sbPymTzb6RH5knV5s633xhz7IXea+K6RkyAk6Mmv7mxAJoK/zgOwM/ZkLm1uXHBRJkBw
         IZ6e9kH59lneH6EiZECXQ5lyOMpH5OEhp9R/5hA3PDuGLLC/xBHBTg6a6oQ0huxYrc+6
         EnD6brQtBZm3nIATVcia/nhn2Eqozh/SF/J2jTNB8LtbFv7+a4xRCAuow0263sNE0haS
         Nrx8fWFlcBTzR87I8BU7Mw8xdUWSyfSUxYQE6Ug9B/g8SjOzMSzM38LODOKzBFZFtRV1
         Vmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :references:user-agent:mime-version;
        bh=r9fNXfRbdc5ZvafBNWErX1+dlYsQ8FGynZjrFEqrCDQ=;
        b=vpXH4NEOyu3SmzJruYrsu74n2lebVWDn4uFzDSvIP/mvlNl3340k+yDSLY2fHolRI/
         Ao2sc6j33zYsf8na80ld2joieqHk5Ycx2pUnI9JADq1NjA2f8hIZYCvo7Qg09qJTLyPq
         T7ldyRbyuL0IOYtAcL7chJ8RTD/xdve3IPCJe8ip9rf6Yd69h7xvtw6aPmweq4jc7xSV
         5EnoscL6Kwz+eW0tfTbs6tfdACj43QdoXxIDgW+Hkt+ItSQya+he8wmPzNM9DoZDKhim
         LFBMogpiTFW+75R34ufvBAIZjsorlF/N6Bac/eH5WQ1VUp6tPaBTIx4RaYXHBVK/CCgO
         Je5w==
X-Gm-Message-State: AJIora/fh6uLm2ZFRs5GGaDyGQ+vp8nDG3Eqx0GMhSUSnAflUXFBiyws
        Rn9iJJxx30+DQhL5W8J2Oz2sdGnJ7vvDOtr/
X-Google-Smtp-Source: AGRyM1uSWRYUuIs7wmTBAvcy8FFXqoXJcNXmPIIzYyY5nnuyuKjoFBhWtTDW2jdv08Ck95bpv+EJ+w==
X-Received: by 2002:adf:dc0d:0:b0:21d:ea5:710f with SMTP id t13-20020adfdc0d000000b0021d0ea5710fmr26441065wri.48.1656932404965;
        Mon, 04 Jul 2022 04:00:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:dc4:4125:ca49:32b7])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d434f000000b0021b970a68f9sm30163025wrr.26.2022.07.04.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:00:04 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf@vger.kernel.org, corbet@lwn.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
        (Dave Tucker's message of "Thu, 30 Jun 2022 13:04:09 +0100")
Date:   Mon, 04 Jul 2022 11:39:53 +0100
Message-ID: <m2y1x940w6.fsf@gmail.com>
References: <cover.1656590177.git.dave@dtucker.co.uk>
        <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
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

Dave Tucker <dave@dtucker.co.uk> writes:

> +Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by

It looks to be 5.5 according to bootlin:

https://elixir.bootlin.com/linux/v5.4.203/A/ident/BPF_F_MMAPABLE
https://elixir.bootlin.com/linux/v5.5/A/ident/BPF_F_MMAPABLE

> +Array elements can also be added using the ``bpf_map_update_elem()`` helper or
> +libbpf API.
> +
> +Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
> +To clear an array element, you may use ``bpf_map_update_eleme()`` to insert a
> +zero value to that index.

Typo in bpf_map_update_elem().

Thanks!
--
Donald Hunter
