Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AD6E707A
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 02:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjDSAgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 20:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDSAgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 20:36:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027D97
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 17:36:43 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so166923407b3.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681864602; x=1684456602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGAkxSBwhKH4DHLayYS1jEVvCVtRgPOBDhfHHuuS4A4=;
        b=G2VLkrKM9bJxlkfgoB1RrhWLkIcy7CX/z93znb0f8/9+6ArjxlD7wNNvbmKqvvYSOf
         2/LXbrWvMNqKwgrP8qdOodp7pCoXBb6jQdUSnPvs65PDN6F5pagbAZfswLlyHQXTnhYN
         1wZRAP2bSZhpCEk1fXo2tFfmLD+A7dEgHsX3wKAUJxPcHI6zMfe149IoH8xLOchW8k+O
         01gm6WEOCTBwPfjVgDh59/ysGrwxJZRKChN8yyW5oC4n1oWmO3ajM0Cer/nSIkSdoZSs
         PEzJGge/H/VIpRvsjGhQuaL6Mz1HBM6xkq6ijdDFxDOO8JJqNJlJcLkb5Fgptn3Z7rp/
         PCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681864602; x=1684456602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGAkxSBwhKH4DHLayYS1jEVvCVtRgPOBDhfHHuuS4A4=;
        b=IpmKRF/W4GFeOYuRwNpZwPU735XYzxSmPjfNPR1g0aQCSJ/HZsqTh8gD7MrMQn6sMc
         X9ISOpOIKMxZ5a+gM+eSUtZG+2ynHX1jWuE+6nuNX7BDRqgLC3bPfbb92EEYYi64BcHI
         5cU7qx+MA3svFk7o9IJw+L3Gp7FUUti3YIlWtHPmUpsD7Pb9qvhrRSlMqekQia6naZx8
         9FfooMf8qdG1yaYfxjqxQt6tv7E5E5saoGZSPBJnn2qi1dBgKp31RYFDJ+OpuM6QGoaY
         zfZ9nsSslzzSLit8wLgerulPZCqpT9ta+rdVr9ZkpODDHT3WQnuboyCqeg/f7apVMybk
         grmg==
X-Gm-Message-State: AAQBX9dw0FYmTbf4dPtX53sCvpMK4xTk7qDvyumGjrI7lpOCbNXqHzSf
        w2PtcPmF2CJjK4b0nx1z13Y=
X-Google-Smtp-Source: AKy350a/fonSXVt3DtMkARvK4KtR7THCXVqhwEYyL0fuBG842IX5JVaomfWs/DbHIdf3kcc55LDhzg==
X-Received: by 2002:a0d:f344:0:b0:54f:bae3:18b6 with SMTP id c65-20020a0df344000000b0054fbae318b6mr1649173ywf.45.1681864602391;
        Tue, 18 Apr 2023 17:36:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240::38? ([2600:1700:6cf8:1240::38])
        by smtp.gmail.com with ESMTPSA id 126-20020a810884000000b0054f882539b1sm4136558ywi.109.2023.04.18.17.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 17:36:41 -0700 (PDT)
Message-ID: <a02b37d9-279a-00c1-351c-a4da23b54abf@gmail.com>
Date:   Tue, 18 Apr 2023 17:36:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpftool: Register struct_ops with a link.
Content-Language: en-US, en-ZW
To:     Quentin Monnet <quentin@isovalent.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
References: <20230418200058.603169-1-kuifeng@meta.com>
 <CACdoK4LU6Zh341YYQTgsciRhfMZYP--+_mY_=+HfBW7hBFmF7A@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACdoK4LU6Zh341YYQTgsciRhfMZYP--+_mY_=+HfBW7hBFmF7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/23 15:55, Quentin Monnet wrote:
> On Tue, 18 Apr 2023 at 21:01, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> You can include an optional path after specifying the object name for the
>> 'struct_ops register' subcommand.
>>
>> Since the commit 226bc6ae6405 ("Merge branch 'Transit between BPF TCP
>> congestion controls.'") has been accepted, it is now possible to create a
>> link for a struct_ops. This can be done by defining a struct_ops in
>> SEC(".struct_ops.link") to make libbpf returns a real link. If we don't pin
>> the links before leaving bpftool, they will disappear. To instruct bpftool
>> to pin the links in a directory with the names of the maps, we need to
>> provide the path of that directory.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/bpf/bpftool/struct_ops.c | 86 ++++++++++++++++++++++++++++------
>>   1 file changed, 72 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
>> index b389f4830e11..d1ae39f9d8df 100644
>> --- a/tools/bpf/bpftool/struct_ops.c
>> +++ b/tools/bpf/bpftool/struct_ops.c
>> @@ -475,21 +475,62 @@ static int do_unregister(int argc, char **argv)
>>          return cmd_retval(&res, true);
>>   }
>>
>> +static int pathname_concat(char *buf, int buf_sz, const char *path,
>> +                          const char *name)
>> +{
>> +       int len;
>> +
>> +       len = snprintf(buf, buf_sz, "%s/%s", path, name);
>> +       if (len < 0)
>> +               return -EINVAL;
>> +       if (len >= buf_sz)
>> +               return -ENAMETOOLONG;
>> +
>> +       return 0;
>> +}
> 
> This is nearly identical to the one in prog.c. If we do need this, we
> should move it to common.c and reuse it.

Got it!

> 
>> +
>> +static int pin_link(struct bpf_link *link, const char *pindir,
>> +                   const char *name)
>> +{
>> +       char pinfile[PATH_MAX];
>> +       int err;
>> +
>> +       err = pathname_concat(pinfile, sizeof(pinfile), pindir, name);
>> +       if (err)
>> +               return -1;
>> +
>> +       err = bpf_link__pin(link, pinfile);
>> +       if (err)
>> +               return -1;
>> +
>> +       return 0;
>> +}
>> +
>>   static int do_register(int argc, char **argv)
>>   {
>>          LIBBPF_OPTS(bpf_object_open_opts, open_opts);
>> +       __u32 link_info_len = sizeof(struct bpf_link_info);
>> +       struct bpf_link_info link_info = {};
>>          struct bpf_map_info info = {};
>>          __u32 info_len = sizeof(info);
>>          int nr_errs = 0, nr_maps = 0;
>> +       const char *pindir = NULL;
>>          struct bpf_object *obj;
>>          struct bpf_link *link;
>>          struct bpf_map *map;
>>          const char *file;
>>
>> -       if (argc != 1)
>> +       if (argc != 1 && argc != 2)
>>                  usage();
>>
>>          file = GET_ARG();
>> +       if (argc == 1)
>> +               pindir = GET_ARG();
>> +
>> +       if (pindir && mount_bpffs_for_pin(pindir)) {
>> +               p_err("can't mount bpffs for pinning");
>> +               return -1;
>> +       }
>>
>>          if (verifier_logs)
>>                  /* log_level1 + log_level2 + stats, but not stable UAPI */
>> @@ -519,21 +560,38 @@ static int do_register(int argc, char **argv)
>>                  }
>>                  nr_maps++;
>>
>> -               bpf_link__disconnect(link);
>> -               bpf_link__destroy(link);
>> -
>> -               if (!bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
>> -                                           &info_len))
>> -                       p_info("Registered %s %s id %u",
>> -                              get_kern_struct_ops_name(&info),
>> -                              bpf_map__name(map),
>> -                              info.id);
>> -               else
>> +               if (bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
>> +                                          &info_len)) {
>>                          /* Not p_err.  The struct_ops was attached
>>                           * successfully.
>>                           */
>> -                       p_info("Registered %s but can't find id: %s",
>> -                              bpf_map__name(map), strerror(errno));
>> +                       p_err("Registered %s but can't find id: %s",
>> +                             bpf_map__name(map), strerror(errno));
> 
> See comment right above: p_info() is probably enough here. If for some
> reason we do need to switch to an error message and change the
> existing behaviour, can you please motivate it and make it a separate
> commit (and update the comment)?

Ok! I will revert this change concerning about behavior changing.

> 
>> +                       nr_errs++;
>> +               } else if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
>> +                       p_info("Registered %s %s id %u",
>> +                              get_kern_struct_ops_name(&info),
>> +                              info.name,
>> +                              info.id);
>> +               } else if (bpf_link_get_info_by_fd(bpf_link__fd(link),
>> +                                                  &link_info,
>> +                                           &link_info_len)) {
>> +                       p_err("Registered %s but can't find link id: %s",
>> +                             bpf_map__name(map), strerror(errno));
>> +                       nr_errs++;
>> +               } else if (pindir && pin_link(link, pindir, info.name)) {
> 
> Why do we have "pindir" and not a pinned path? Instead of taking a
> directory name to concatenate, why not let the user specify the pinned
> path directly, as we do for maps, programs, and links already? The
> only existing use of dirname + concat I can think of is for "bpftool
> prog loadall", but this is because we need one path to pin multiple
> programs. Here we just have one, so let the user choose their path?

We could have multiple struct_ops in an object file as well.

> 
> I would also avoid using "pin" too much in variable or function names.
> I know we have "bpf_link__pin()", but I find it makes things confusing
> between the concepts of pinned objects (through BPF_OBJ_PIN) and of
> BPF links. How about "linkdir" or "linkpath" instead?

It sounds good!

> 
>> +                       p_err("can't pin link %u for %s: %s",
>> +                             link_info.id, info.name,
>> +                             strerror(errno));
>> +                       nr_errs++;
>> +               } else
>> +                       p_info("Registered %s %s map id %u link id %u",
>> +                              get_kern_struct_ops_name(&info),
>> +                              info.name, info.id, link_info.id);
> 
> Missing curly brackets on the "else" block.
> 
> I find it not easy to follow the logic in this long "else if..."
> chain, it would probably feel more natural with simple "if"s and some
> "goto"s to reach the bpf_link__disconnect() call below. But maybe this
> is just me.

I agree actually! I implemented it with goto first, but move to if-else 
to following the style I found in map.c. If you think goto is better, I 
will be glad to move to it.

> 
>> +
>> +               bpf_link__disconnect(link);
>> +               bpf_link__destroy(link);
>> +
> 
> Nit: We don't need this empty line.
> 

Got it!

>>          }
>>
>>          bpf_object__close(obj);
>> @@ -562,7 +620,7 @@ static int do_help(int argc, char **argv)
>>          fprintf(stderr,
>>                  "Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
>>                  "       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
>> -               "       %1$s %2$s register OBJ\n"
>> +               "       %1$s %2$s register OBJ [PATH]\n"
> 
> This is not enough to understand what PATH means here. I'd use
> something like "LINK_DIR", or preferably "LINK_PATH" if we let users
> specify the full path. And we need to update the
> bpftool-struct_ops.rst man page (under bpftool's Documentation/) to
> explain what this optional argument is for, can you please take care
> of this?

Sure!

> 
> We usually have to update the bash completion too, but it seems that
> it offers filenames multiple times already after "bpftool struct_ops
> register", which is not intentional but covers completion for the new
> argument.

I didn'know about bash completion before.
Good to know!

> 
>>                  "       %1$s %2$s unregister STRUCT_OPS_MAP\n"
>>                  "       %1$s %2$s help\n"
>>                  "\n"
>> --
>> 2.34.1
>>
