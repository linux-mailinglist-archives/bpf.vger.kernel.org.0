Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF964535F
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 06:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLGFUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 00:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGFUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 00:20:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8525C5477E;
        Tue,  6 Dec 2022 21:20:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so424276pje.5;
        Tue, 06 Dec 2022 21:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNGhpjlW4qLEt6OLZu34U3BRZ2e6HzCsg12lOUw/1YA=;
        b=i4v9yin+xhLKmKakXQ2BhgKZEHeuryEJRm4sJU1+dmd/nnb33YIGs9/Iu0TUNDNigZ
         JgMvrRXf7IG12UWcvb7BQRYzEhobeABigGl9Udk5A9dzSkvhtcMOFxA++brhkuB3ILek
         zN584wNSGci/WPbkxDNu89eNgzjHgc2zMK2/dydU0NkO6F8xUelBy60ShL3o/+NR7b8Z
         RpNx59VxCbxMjN9b1vcVPZEIE4mCYI8eN/I//PwHoIbSiBKZPvlmB7JWcEBw44PiZKbl
         Mx+94LBYznBYhLQeX+iXJSwRGtdNrzm5HMVtPFSiKmpm/IXz7Rqjl+KwZVavTpekYfCh
         Vejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNGhpjlW4qLEt6OLZu34U3BRZ2e6HzCsg12lOUw/1YA=;
        b=tVapBT+cQ2hzg+B3zBg51Id9sEmEw13DpWLyAOu0ItZYQ/l3cscD4dghQN84CwbuMk
         gux1Hq2gg7rB4/JfXEDtYPBZtkbFRbnn2QqFGGUmDChN36vsyePEo8Ekm4hzzfAv6VmW
         byycVhTBEJlqGftg2R4h045DEuO3pBrc4K1fS7eU+/h+5RwRuhNgIMcfR+v9QxdAqQy6
         uJsSPiNkQfynJDx4GoPOPL2l2KkdSgXBYBrb1eh+Qo71Y3Eoo6L5eeAHoTVUyzozx2Ql
         e40b0SbsVWr8WM/KYaaF8OCTp2/Kj1tDjm+8eHEtQ29Ye/hrPa6p/NJFFyrdJG79HSQ5
         b2Xg==
X-Gm-Message-State: ANoB5pm9PevHnavBC1BfzpMEn5NFcBCrn7NZiGLdvAz9PMmSSUq+n0N5
        k65QySP0oWruNG7hBfJHeqQ=
X-Google-Smtp-Source: AA0mqf7Erw9TgQAj4ayg4TMx0pfKZODacuCej75AXZt2xrojyGQJJ7cP8ACRdBkvD5zEgkl+tfA5YA==
X-Received: by 2002:a17:90a:7a82:b0:211:55d8:4cdd with SMTP id q2-20020a17090a7a8200b0021155d84cddmr95903229pjf.133.1670390412962;
        Tue, 06 Dec 2022 21:20:12 -0800 (PST)
Received: from localhost ([98.97.38.190])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902a70600b00174f7d10a03sm4113399plq.86.2022.12.06.21.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 21:20:12 -0800 (PST)
Date:   Tue, 06 Dec 2022 21:20:08 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        john.fastabend@gmail.com, bagasdotme@gmail.com,
        Maryam Tahhan <mtahhan@redhat.com>
Message-ID: <63902288c7bd_bb362086d@john.notmuch>
In-Reply-To: <20221202114010.22477-1-mtahhan@redhat.com>
References: <20221202114010.22477-1-mtahhan@redhat.com>
Subject: RE: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@ wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> 
> ---
> v3:
> - Call out that the user attaches the BPF programs to
>   the sock[map|hash] maps explicitly.
> - Rephrase the note that references the TCP and UDP
>   functions that get replaced.
> - Update simple example to attach verdict and parser
>   progs to a map.
> 
> v2:
> - Fixed typos and user space references to BPF helpers.
> - Added update, lookup and delete BPF helpers.
> ---
> ---

Still LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
