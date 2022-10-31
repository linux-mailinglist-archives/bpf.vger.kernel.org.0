Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F094613B37
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 17:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiJaQZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiJaQZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 12:25:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383612638;
        Mon, 31 Oct 2022 09:25:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso7042303otb.6;
        Mon, 31 Oct 2022 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pw0335W0x9oZfyMmuIq2S0vNgEk0CvJ7i0QAo6WUANc=;
        b=RJp722HlKd0PtsLIg9mOY0BXPikP+61nGYHxQzyXQx8h1ClmmV2DLUhdENJi6qkKgG
         sYZ3OJkJiF+ZoTQz3RRMmc5eyO31sAhFuD4rKlRpDjEWrAGvhy1dRJkeLazqsjOOUtmZ
         0iEEGuuWUyBJdAADwCGuZ9Acvw9fuqCEFJ7wmbe2FfbyVFqZXLZnbZf85K04GVN5YEx+
         LVdFEQh9mcYkARSWbsR+ol6gCWI6h/iOEEME1+fQE6lheLldRmWydQwOJIujEnLnvRTo
         maxnzwSPm9KcvNmQPa4GL51l4YCD1S48Jk8IA/x3zBu2SS9gkpAaabcGSqiXmJos9B4x
         f3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw0335W0x9oZfyMmuIq2S0vNgEk0CvJ7i0QAo6WUANc=;
        b=jIJ0HF112Mfx5m9odKWlg4YmKBz5FUG3h0QiNFzB6NGoPCaLFnt5X+vrNO22RqOsg9
         Gbyx/8WlcIv1jLvOP7XWYCQr+XAFy2LpOZ4/CKsPzLFUz6HSibXh1kdfzkXZze7ZmVyV
         nOV4zPpvLYbMrYCrLZa5mdAQi46F5FtLx8/LWk4ivEkMwbxE5HaC9nYRayCwmzuoq0qV
         NJ/ZuRnUIleggEs5/cmtL6qXf6EmKZOK7w0CdgVVzE7eMPzD8nAP7AIEHYdufSZa6ZJ7
         HZiUEvw3fQS7R4I7wQ/cSPYJdVB0Iluva9c1FCJUO8DRZOcAsAWswExjOPYhmu52d6Y0
         65DA==
X-Gm-Message-State: ACrzQf1oL12ycDhLead6HkC6Sux7HT9YvlhYXh0g1+PzAAtOKgYx6AXY
        HScEg00zYYxmlvVJB5s2tuaXx1GdJmwPVzWegO9EbuVaErHlDIba
X-Google-Smtp-Source: AMsMyM6Y7aPtBXKfQrdZR2AUh6UgRSg0PZpuDTmqQk7MsyokcBUwll9ppSVI6El6XozGY8guSIb/EuOpH1b3UiI5i1Y=
X-Received: by 2002:a9d:6f83:0:b0:66c:5987:54 with SMTP id h3-20020a9d6f83000000b0066c59870054mr1509070otq.267.1667233533671;
 Mon, 31 Oct 2022 09:25:33 -0700 (PDT)
MIME-Version: 1.0
From:   Isaac Matthews <isaac.jmatt@gmail.com>
Date:   Mon, 31 Oct 2022 16:25:22 +0000
Message-ID: <CAFrssUQKyfZXXXQQA2vPMLR957RZtt7MN9rEG_VbLW_D0wBZ0w@mail.gmail.com>
Subject: Possible bug or unintended behaviour using bpf_ima_file_hash
To:     linux-integrity@vger.kernel.org, bpf@vger.kernel.org
Cc:     isaac.matthews@hpe.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using bpf_ima_file_hash() from kernel 6.0.

When using bpf_ima_file_hash() with the lsm.s/file_open hook, a hash
of the file is only sometimes returned.  This is because the
FMODE_CAN_READ flag is set after security_file_open() is already
called, and ima_calc_file_hash() only checks for FMODE_READ not
FMODE_CAN_READ in order to decide if a new instance needs to be
opened. Because of this, if a file passes the FMODE_READ check  it
will fail to be hashed as FMODE_CAN_READ has not yet been set.

To demonstrate: if the file is opened for write for example, when
ima_calc_file_hash() is called and the file->f_mode is checked against
FMODE_READ, a new file instance is opened with the correct flags and a
hash is returned. If the file is opened for read, a new file instance
is not returned in ima_calc_file_hash() as (!(file->f_mode &
FMODE_READ)) is now false. When __kernel_read() is called as part of
ima_calc_file_hash_tfm() it will fail on if (!(file->f_mode &
FMODE_CAN_READ)) and so no hash will be returned by
bpf_ima_file_hash().

If possible could someone please advise me as to whether this is
intended behaviour, and is it possible to either modify the flags with
eBPF or to open a new instance with the correct flags set as IMA does
currently?

Alternatively, would a better solution be adding a check for
FMODE_CAN_READ to ima_calc_file_hash()? I noticed in the comment above
the conditional in ima_calc_file_hash() that the conditional should be
checking whether the file can be read, but only checks the FMODE_READ
flag which is not the only requirement for __kernel_read() to be able
to read a file.

Thanks for your help.
Isaac
