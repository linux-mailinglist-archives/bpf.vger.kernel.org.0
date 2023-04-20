Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81B6E865B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDTAXM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDTAXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:23:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8588759EF
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:22:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b78b344d5so409622b3a.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950178; x=1684542178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=el+HEfZ1ltriZ5YrYnlen/UrCV8vjb/JfDZKgqiEgw4=;
        b=WLnda0z5zW6EDpkrRYamROIj4wXgzVYXfl6YptDNPAKatkROiwOENeh0vdlA06HkSr
         COhuUfgt5l6ihdzuLPsAxMPZCH0nc0Fzxb4LWCHD//VrrLzpkZtGIfZ4FfpGrK+uog5q
         ga/cAyM2/j3F53DtiZeh2okWTQWX9kJQkSkhAvkH9+7csKXyP8GuW7CST1aRA8lyBPzN
         jjfmtrLfQKdbtCgue85uE+A53nIcm0KIqgQ6EXz/bogYXDcNg62JxDJf2ly7RAXKAuwn
         UaPOVMCsGyQGZF4iEhrFi1cYFQoku3Bj1jhd2r9oUPp8Ff5XSZSZIaZgahzx73urG5b9
         YQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950178; x=1684542178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=el+HEfZ1ltriZ5YrYnlen/UrCV8vjb/JfDZKgqiEgw4=;
        b=AZRhm9tHTrZ+ZUJeVWB9VvU42oe+tjNlDIrSBvH1sPdB1ctjUMViFJF/kIE3WrXrNo
         JNWvRdb0gREcSvvdO7R+g7UzTvQsRpSm++W2mkxrfdjMC4/mx/2exnMx8YEaEra1TEgg
         v9+NBb+++Zghahzq2dI1aAqDE6weH4eN7fOnwyxWncoVCKkSuGi+ZjXxuf0tD1rQ5Y/v
         e+GmNMWrnIIqTgJY8ZgLkvQ4Rz/psCyHXcm0xNPbfTvhdY0nR9xUbV58peQk8iJ8mo+w
         pR8/jywfbgk72YX3ZlI+HpjDmHvp6i08MUQDog+qc0cTmM0j+NI+Os2euom5i/Yz3w/v
         YdnQ==
X-Gm-Message-State: AAQBX9cXH+zTVdcO92Rx6Qnv24IeHeTLWDbzWrhM/47tGOQDgOqBA0jK
        lb0QX2mDr5CjYVjbjgec017Gt+CedYs=
X-Google-Smtp-Source: AKy350bQi/5sKRKFQMTGZ3t1T9v3f7YTlqntR2FyYhVFxPNBgzN1swglb6qh1mg6oonfYa9gJCX8yQ==
X-Received: by 2002:a05:6a20:4412:b0:f0:e8a5:17cc with SMTP id ce18-20020a056a20441200b000f0e8a517ccmr536394pzb.11.1681950177883;
        Wed, 19 Apr 2023 17:22:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::11e9? ([2620:10d:c090:400::5:b0fd])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78744000000b0062dba4e4706sm1855484pfo.191.2023.04.19.17.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:22:57 -0700 (PDT)
Message-ID: <a5d5b949-7c25-c2db-20c9-fe6cf68ca665@gmail.com>
Date:   Wed, 19 Apr 2023 17:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Register struct_ops with a link.
Content-Language: en-US, en-ZW
To:     Quentin Monnet <quentin@isovalent.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
References: <20230419025625.1289594-1-kuifeng@meta.com>
 <CACdoK4+xMGOoN_id2NVBDmYjxLCi_JY40UpmuBiadEUWi-u0ng@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACdoK4+xMGOoN_id2NVBDmYjxLCi_JY40UpmuBiadEUWi-u0ng@mail.gmail.com>
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



On 4/19/23 16:40, Quentin Monnet wrote:
> On Wed, 19 Apr 2023 at 03:56, Kui-Feng Lee <thinker.li@gmail.com> wrote:
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
> 
> Right I'd forgotten we could register several struct_ops at once with
> the command. OK then, makes sense to pass a directory and pin with the
> existing names in that case.
> 
> This patch looks all good, apart from a few indent nitpicks.
> 
>> ---
>>   tools/bpf/bpftool/common.c     | 14 +++++++
>>   tools/bpf/bpftool/main.h       |  3 ++
>>   tools/bpf/bpftool/prog.c       | 13 ------
>>   tools/bpf/bpftool/struct_ops.c | 76 ++++++++++++++++++++++++++++------
>>   4 files changed, 80 insertions(+), 26 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index 5a73ccf14332..1360c82ae732 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -1091,3 +1091,17 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>>          default:        return libbpf_bpf_attach_type_str(t);
>>          }
>>   }
>> +
>> +int pathname_concat(char *buf, int buf_sz, const char *path,
>> +                   const char *name)
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
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index 0ef373cef4c7..f09853f24422 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -262,4 +262,7 @@ static inline bool hashmap__empty(struct hashmap *map)
>>          return map ? hashmap__size(map) == 0 : true;
>>   }
>>
>> +int pathname_concat(char *buf, int buf_sz, const char *path,
>> +                   const char *name);
>> +
>>   #endif
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index afbe3ec342c8..6024b7316875 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -1472,19 +1472,6 @@ auto_attach_program(struct bpf_program *prog, const char *path)
>>          return err;
>>   }
>>
>> -static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
>> -{
>> -       int len;
>> -
>> -       len = snprintf(buf, buf_sz, "%s/%s", path, name);
>> -       if (len < 0)
>> -               return -EINVAL;
>> -       if ((size_t)len >= buf_sz)
>> -               return -ENAMETOOLONG;
>> -
>> -       return 0;
>> -}
>> -
>>   static int
>>   auto_attach_programs(struct bpf_object *obj, const char *path)
>>   {
>> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
>> index b389f4830e11..41643756e400 100644
>> --- a/tools/bpf/bpftool/struct_ops.c
>> +++ b/tools/bpf/bpftool/struct_ops.c
>> @@ -475,21 +475,48 @@ static int do_unregister(int argc, char **argv)
>>          return cmd_retval(&res, true);
>>   }
>>
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
> 
> "return bpf_link__pin(link, pinfile);" would work as well. But I don't
> mind much.

I will change to this.

> 
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
>> +       const char *linkdir = NULL;
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
>> +               linkdir = GET_ARG();
>> +
>> +       if (linkdir && mount_bpffs_for_pin(linkdir)) {
>> +               p_err("can't mount bpffs for pinning");
>> +               return -1;
>> +       }
>>
>>          if (verifier_logs)
>>                  /* log_level1 + log_level2 + stats, but not stable UAPI */
>> @@ -519,21 +546,44 @@ static int do_register(int argc, char **argv)
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
>>                          p_info("Registered %s but can't find id: %s",
>> -                              bpf_map__name(map), strerror(errno));
>> +                             bpf_map__name(map), strerror(errno));
> 
> I think the indent was correct and this change results from your
> previous version with "p_err()"?

Yes, it is my bad!

> 
>> +                       goto clean_link;
>> +               }
>> +               if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
>> +                       p_info("Registered %s %s id %u",
>> +                              get_kern_struct_ops_name(&info),
>> +                              info.name,
>> +                              info.id);
>> +                       goto clean_link;
>> +               }
>> +               if (bpf_link_get_info_by_fd(bpf_link__fd(link),
>> +                                                  &link_info,
> 
> Please fix the indent.
Sure

> 
>> +                                           &link_info_len)) {
>> +                       p_err("Registered %s but can't find link id: %s",
>> +                             bpf_map__name(map), strerror(errno));
>> +                       nr_errs++;
>> +                       goto clean_link;
>> +               }
>> +               if (linkdir && pin_link(link, linkdir, info.name)) {
>> +                       p_err("can't pin link %u for %s: %s",
>> +                             link_info.id, info.name,
>> +                             strerror(errno));
>> +                       nr_errs++;
>> +                       goto clean_link;
>> +               }
>> +               p_info("Registered %s %s map id %u link id %u",
>> +                      get_kern_struct_ops_name(&info),
>> +                      info.name, info.id, link_info.id);
>> +
>> +clean_link:
>> +               bpf_link__disconnect(link);
>> +               bpf_link__destroy(link);
>>          }
>>
>>          bpf_object__close(obj);
>> @@ -562,7 +612,7 @@ static int do_help(int argc, char **argv)
>>          fprintf(stderr,
>>                  "Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
>>                  "       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
>> -               "       %1$s %2$s register OBJ\n"
>> +               "       %1$s %2$s register OBJ [LINK_DIR]\n"
>>                  "       %1$s %2$s unregister STRUCT_OPS_MAP\n"
>>                  "       %1$s %2$s help\n"
>>                  "\n"
>> --
>> 2.34.1
>>
