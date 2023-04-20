Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4467F6E86AD
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjDTAmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDTAmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:42:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F6319BF
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:42:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt6so2822354ejb.0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681951370; x=1684543370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=If4GzO9PhViQX2Q9MwcVAV6O0mN1CeX4c6rXjqy5WCY=;
        b=C9nopWZaks2SISD9F57OEo47joFwZVzw6dkT1RPPUVIEd9WDU86e3Ur+phvb3J+7lK
         Ojwxojbfx+mFmYiFveFskQyUgCEEo4OEt9nNcaQxgEj78ywDHMiWaA7oNGMa+Ocxwkew
         40VkvRNhI20z91/2F186y8rrxshejyDCM5Axssdx3+ZL7cknP2fgBrxAUGLpDIpwh7Bp
         Uxm/KWuwUrIfg3iRsnp0z1p5EPeTrfjN+8iQzU4LDcsYBdHbtqOJ38g9ENE3Wp7C4tEx
         UN3eSS8ccMRQBqNIC9RfOEJvm49DuJbKKrooUjINyxA5vE/wBajNYUukY4sDV/2jq+zG
         NJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951370; x=1684543370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If4GzO9PhViQX2Q9MwcVAV6O0mN1CeX4c6rXjqy5WCY=;
        b=SnyBJZiwt2FyQylo9crhtLp8AkYwBtv3q98h3lU71j56/IK2ia5+Fnw2hLX12cS2ZL
         aQfmQwpl1xT2YP1J2yRrh3KFAD3ewoHwXY8arAPJnc7AEKCTIZMnInBX+ar7feTQ5xtD
         v3HeDB7D0w3OuVyocFVHD0M1vhYgID9a4l7OGOfJxWT8mJjFgQZgAm+kTlvGquDmfXQ1
         vcRwbF5SMs5vh6kGOBT8hV6kZn63KX2uA8RSZXGwKTL5IZG/n+tCLTNVI2zGi6NsF/wn
         N8BPNw01uBUWpDlAhxzvOnDU0xFeK4upc06g6pAX7dyeLmCxwoK56uUsyZq4moxXAqq2
         /Z1Q==
X-Gm-Message-State: AAQBX9cqowHyXSAUR4HXTbxp5not0sCcNhGhV/s9JphpJUBJUCLBJoIg
        ohmtSgQj7+LzNef9pUBzQlKT7W4Hgm+9vezs/NsB0w==
X-Google-Smtp-Source: AKy350aP8i8M4YY7Zps4S5wR1K1Y7BUNvTUoajHHp1bDRvKRedfYs27pwMhNhLgNiDt7gk8CON158LGenKzPxOQFwZ4=
X-Received: by 2002:a17:906:5610:b0:94d:a2c2:9aeb with SMTP id
 f16-20020a170906561000b0094da2c29aebmr16737208ejq.49.1681951370238; Wed, 19
 Apr 2023 17:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230420002822.345222-1-kuifeng@meta.com> <20230420002822.345222-2-kuifeng@meta.com>
In-Reply-To: <20230420002822.345222-2-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 01:42:39 +0100
Message-ID: <CACdoK4L_pWMS7MVHMS7idQn4vFrcE5WQLoJSruAgoDDVwxk-8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Update doc to explain struct_ops
 register subcommand.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Apr 2023 at 01:28, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> The "struct_ops register" subcommand now allows for an optional *LINK_DIR*
> to be included. This specifies the directory path where bpftool will pin
> struct_ops links with the same name as their corresponding map names.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!
