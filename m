Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138DD60796A
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJUOXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJUOXK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 10:23:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90E5265C69;
        Fri, 21 Oct 2022 07:23:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so5067142wro.7;
        Fri, 21 Oct 2022 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baBFPORy5vTiQBkw0v7ixAwx96dk8TEMFwzUjX+Gapc=;
        b=WdhYzVd7LEsS8IqnR6jf/BILR/moekZtqdnzJ5CzWI9iff/fWzChKfVy94WyyX2zAB
         V7sJFn9aVqLlZK2zF1RjBgsrKxBmLyzN8ndWChHuJcPmAO6hfEgwU+i3cXNd+7HeUN1f
         VNJhDp94l3ItOsBzEbNaqnMD45ivSUgjE3kA5qsBJQ7UyZB+ls7kNUETu0lDIElYvTJh
         byN+FxPBkdGNWXwKBXorMtW2PHCWeI78MPb/xgjsqf5M8hTIaZXM52CgxatvGRTStM2A
         cd5yohuwYD95A8bw/8EUo9CLEoJpjeDIu2XVWwGKU55/6v5gn6biCOwwqIc7XqU+mrvj
         Pmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baBFPORy5vTiQBkw0v7ixAwx96dk8TEMFwzUjX+Gapc=;
        b=7bIf40rVNRzLsteSmQRIojJ+i4+WcX0RHXc4RWn6vXEFJ6BLa0YL0fHnfz1zg/JvJw
         ny7tSswRhQFE4iFTzAgtsSsEobcwE2YgTPhYiJD7u2TW/PMYXF1oB3GVJKkobfmfU7I9
         W1DpOJw5P8wkbawDMH1IFP6nez0i2icMPEGLveow8wL3k9ztndcAMxXSuvLaoFd3oY95
         a/o9uwknxAW/1xpxpcYvlIhneEmLlyzbZg9k5k23zTpny8GCAif7jC5T/bxxbAk5qnoB
         +wkYModVEHciix9El8SvAvhKNN9k0KNl5ZtOL1vkohKXcx+43xEeIH1Ycuiu9JeBvquN
         y3pQ==
X-Gm-Message-State: ACrzQf05UITkiLoJFQwwVudhp5X406zVtfVSRD1CSFSrut1ZlzkzDQD4
        xKE8rIzzZX4SZ06XTUezB79ob3pjVsTvBQ==
X-Google-Smtp-Source: AMsMyM5MyoKK2RrzwXAwQe5VLl9Ew2bhTLbTn0XqZv8kGOaAb9EKj8y+pXgxcb3yN648E64BjbyXuQ==
X-Received: by 2002:a5d:4a06:0:b0:22e:3e36:d7e7 with SMTP id m6-20020a5d4a06000000b0022e3e36d7e7mr12876574wrq.410.1666362187727;
        Fri, 21 Oct 2022 07:23:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:cc4f:5367:93c1:b0d5])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b002364c77bc96sm3180522wrz.33.2022.10.21.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:23:07 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v8 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Fri, 21 Oct 2022 15:22:58 +0100
Message-Id: <20221021142259.18093-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add documentation for BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
variant, including kernel version introduced, usage and examples.

v7->v8:
- Fix alignment wording reported by Alexei Starovoitov
- Avoid deprecated functions, reported by Alexei Starovoitov
- Fix code sample formatting, reported by Alexei Starovoitov

v6->v7:
- Remove 2^32 reference and reword paragraph
  reported by Jiri Olsa and Daniel Borkmann

v5->v6:
- Rework sample code into individual snippets
- Grammar mods suggested by Bagas Sanjaja

v4->v5:
- Use formatting consistent with *_TYPE_HASH docs
- Dropped cgroup doc patch from this set
- Fix grammar and typos reported by Bagas Sanjaya
- Fix typo and version reported by Donald Hunter
- Update examples to be libbpf v1 compatible

v3->v4:
- fix doctest failure due to missing newline

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (1):
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst | 243 ++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.35.1

