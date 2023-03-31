Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7386D164C
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCaETe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 00:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCaETd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 00:19:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA98DB
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 21:19:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bt19so13999733pfb.3
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680236372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5mOv7NSKjFfMY8yrK5WQOXjoi7JFrW6vfobt2U6KrY=;
        b=dNkb++u1TZAsfigyDJ1z/rekFtwSa3dE0qcEewMRy2/Ff9H6I7xhl/b6JF4zjxMdvP
         Mi4w7AQWj3SQxlpgoqd45ZELhHgqFSumRB7ZPwp4WQzmgpA0ftv6yq/AS/q2gxA3m+rM
         F5/xjfMJ2TcM899DzOj8tu8/bDHVIeIJNkQNZ1cet3ROh0rVAsSXbxehTFqtw9zbeSz/
         5dZXCYQkPOgI4PbuI7JLn31h08EF3ab5MU0DtDYu6CWTp0EprHTjZXS6JJ5RoSmWliax
         GlTfHoE1cuRK4oG7Kf/i0A9V9nWUNqjn58N394gXWqjEk/Spz9PhsJTxodgjnFg7xpyu
         ViKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680236372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5mOv7NSKjFfMY8yrK5WQOXjoi7JFrW6vfobt2U6KrY=;
        b=rxd3zZk3GFod+kW9QwPfQpTIvYxb9m4J5nNOXMi+FymQLB9dYp2iJ1/hh6kSY+MO85
         hXaPxDmFxRe2KvqgQLk+GaN0COhEl9jgC595Y31K/ePtFD3Wzewf2aCogg5qOBqffyO6
         +JLYyJPj5bVAI+D9gdlB4sZDGAjCZ+CZ1NgvivMDKmztx3yuXpkofBztOipwsCD2NLz1
         gF7KDCAp6Hk+WZ4hnQrH7jG3WI+CZERP5Me9bHOLKBfUpB+2gdbuZsCFjEWmsjeE75yj
         qAqQNyIIsiBRd6Igx8qTy3PSn4Sj5EEGFweOuhJYz7fp8YLPchd8TpPHx4RRWh4LtbnP
         QjDg==
X-Gm-Message-State: AAQBX9cH/r6YBuxTKJyzQ1iiFYIHUSs2H6lKxTjVtgjp90V0NpMvOqq4
        SZCFKiSGADBEAamcBSK942WrKdaYFIAqxQTmsY3Y3w==
X-Google-Smtp-Source: AKy350bW1ucyVecN8oXAkXmcOLD9lFRXeWUUUF7EXVimNX36BExQLFzCzyAE7IHXNTDhavxmslPvsbb77Y/gUNLiYIE=
X-Received: by 2002:a65:4986:0:b0:503:25f0:9cc5 with SMTP id
 r6-20020a654986000000b0050325f09cc5mr7165543pgs.2.1680236371584; Thu, 30 Mar
 2023 21:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAFY1_4a5MC0-BkGcRx-5n-vdXZbjjrjEukwur+n4AOXFhMHFw@mail.gmail.com>
 <CAADnVQLcqDOzXPSUUNyFE=UJHBP-ZgOEqFfaGynTUL-jQnw-=w@mail.gmail.com>
 <CAAFY1_66-b063v+edsHPBbK6iuiE=KoY38=kr0FVzVLg5gkE_w@mail.gmail.com>
 <af9d6b81-b3d4-9f48-5ec2-da00c084bf28@huawei.com> <CAAFY1_5YwjwFAj53eoGNsD0gVukrVppf=b7cNznAJOcrhY-PEA@mail.gmail.com>
 <CAAFY1_6A4E8NrX-P9F+kOw1q+_8k7PiTy-0T7h9MNiN3KZ3fdA@mail.gmail.com>
In-Reply-To: <CAAFY1_6A4E8NrX-P9F+kOw1q+_8k7PiTy-0T7h9MNiN3KZ3fdA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Mar 2023 21:19:19 -0700
Message-ID: <CA+khW7hmsP4sPiY8RZG9kHLxZ2tRG1G65TduXbZ6eO1Os4jWPw@mail.gmail.com>
Subject: Re: bpf_timer memory utilization
To:     Chris Lai <chrlai@riotgames.com>
Cc:     Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 10:26=E2=80=AFAM Chris Lai <chrlai@riotgames.com> w=
rote:
>
> forgot to include the call back snippet
> static int myTimerCallback(void *map, struct ip_flow_tuple *key,
> struct ip_flow_entry *val) {
> bpf_map_delete_elem(map, key);
> return 0;
> }

Can you also check the returned value of bpf_map_delete_elem()? I
think there is a possibility that the bpf_timer_cancel_and_free() did
not get called for HASH and the timer gets leaked.

Looking at the path of htab_map_delete_elem(), it may fail in a few
places. For example, if we failed to acquire htab_lock, it returns
EBUSY; if there is race and we failed to find the element, it returns
ENOENT; check_and_free_fields() may also has a chance of failing, but
unfortunately we don't check the returned value.

Hao
