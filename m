Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C2564A4D
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGCWdv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGCWdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 18:33:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359A55B9
        for <bpf@vger.kernel.org>; Sun,  3 Jul 2022 15:33:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so6411484otb.5
        for <bpf@vger.kernel.org>; Sun, 03 Jul 2022 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Hon1eblQtyuzH1IFbwREzcS+AEQm0nDXuu+hKn3igvA=;
        b=748KJBix6Pwq5WyZh7eBrO4aklyMBz2HlJYrjVdomq8bo17VNRFHFFNAsnVyTnXDsE
         7uqF2uaevgrqE9cYQRJuQl59VkyBxmIEFVlOm5Wc0nu+13L4SQtNkzVgSM5nBUW6S3u3
         ZPMtDupdjOA8bNxF5BfKv7q8jbmQSP6AXoaV7SDv829BU9xUnt+8dHfnl5f9+C3Bww30
         evILVMpPOT8/OYLjtNXsBe0TiCUojJR3feFMqNxyKMneaQRyPzdSHvUkFzeSjcQRm0dD
         /KMmQd4RowBaNbWM7SakhzBlB8VbNwrRdgxpzMVHalOCZRjPT97/QRseMpt3iZD/UrG7
         zzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Hon1eblQtyuzH1IFbwREzcS+AEQm0nDXuu+hKn3igvA=;
        b=qjtUR7BHV9GrRrMSDgMEfGLcXqzOAzcCBcoCFz/coPzXcFGQxysl+MrZuFxe0bivOP
         yTPcZIuGlzROzblEmqtPxf4ZxttVqHyI2VxXo+asMDp5vOcnTfuPYmkTjDEkmqRFOlCu
         aN8SWvUCf0/WOfXq7z6A0XE6xXzR6IaPOHIeEMytoM1+WLfNsFft2G0khMzsLefHoFq9
         aUT9CH5FKXlX4WK+xXlct1h121f5AHnR9KAWMMZXpqbG6NkkE8hIzCQ5FlPzh6bbDlv9
         SVeHg/NIaiftf7h0dB8gdZ9U1VNmELvnQtA3PEtPMV5JBke5fwC2ySa3oryOdd/jhdyJ
         gRQw==
X-Gm-Message-State: AJIora/uN2uCbofjEWN7fUk2T0J5tm+wshSp194Y0lv4W6pG/oqGF/3I
        hN91sYY2oz2qKuDTQsHoi3kiyxsYgg37UA13NGOH63+ISDBXfQ==
X-Google-Smtp-Source: AGRyM1sFoQKvULVz5vmky4x0BEGtuHclfWuCwWocZ4fVX9ndFYu4i3Hbv1Xt4wj2BRt0lERP57C7IAiDMCcwZBFLfco=
X-Received: by 2002:a05:6830:630f:b0:614:d51e:23e6 with SMTP id
 cg15-20020a056830630f00b00614d51e23e6mr11485292otb.210.1656887628922; Sun, 03
 Jul 2022 15:33:48 -0700 (PDT)
MIME-Version: 1.0
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Sun, 3 Jul 2022 15:33:38 -0700
Message-ID: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
Subject: Questions about querying map object information
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

I am super new to bpf and the open source community in general. Please
bear with me asking some basic questions.
We are working on a bpf monitoring tool to track the CPU and memory
usage for all bpf programs loaded in the system. We were able to get
CPU usage per bpf program with the BPF_OBJ_GET_INFO_BY_ID syscall on a
bpf prog object. We are trying to do the same on a map object to query
for per map memory usage. The information returned from bpf_map_info
only contains things like max_entries, key_size, value_size, which can
be used to calculate estimated memory allocation size. But we are also
interested in knowing how much memory is actually being used by our
program. For instance, one of our bpf program uses a map with type
hashtable. The hashtable is created with a chunk of pre-allocated
memory based on the max_entres, key_size and value size. The
pre-allocated size is useful information to know but so is the current
number of entries in the hashtable. We used to run into a performance
issue where our bpf map's max_entries is set to be too small and we
end up totally exhausting the pre-allocated memory. So knowing things
like current entry count VS max entry count of a hashtable is useful
information for us.
With that being said, we have a few questions and hopefully we can get
some help from the community.
1) We couldn't find anything in bpf_map_info to give us the current
entry count of a hashtable. I read that bpf_map_info returns
information about a map object in general. So it makes total sense to
not have information of a particular map type. But is there an
existing place we can get the per map type information (eg, the
current entry count of a hashtable, the number of elements pushed to a
stack, etc)?
2) If there isn't an existing place to return map type specific
information, would it make sense to extend the structure bpf_map_info
with a union at the end and have that union to contain per map type
specific information?

Thanks, Hao
