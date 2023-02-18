Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806969B690
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBRAF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAF0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:05:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8323F47432
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:05:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w9-20020a17090a028900b00236679bc70cso396328pja.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU38O8CouCTtsIER1W1d/4VZ6DU6HwCBKnyEVnK0EZY=;
        b=nzCBGqIOTQpXJQOhCchaOij+dGm6v20rT5OjqqtnXttmPvJBE6rAPJu2/2oaIclcxT
         osPXtoeAhxymjDyl5b9A/tdf1xFLHlWOqSoZ/nM0g1r4IsBK8Bw48hcQ1qBfVm1YaSov
         iLmEmqokCKyeawGovD++PFrnZIaKpyGzFuTNhakjxQUJ91mIKWK9VZqy65i37glUFdbS
         ihVFYH6tSagZUCypUNqyeqxDW/X0bLpgqEgpDqRBv2nmiF0HFeLi+jg/7SNlbFHBJ5iy
         N7x01tT0fZDfE/noqtCv3ll5DpQdQ/Hthye3EFbJGMboz8gBhAPQWV3nB07tax+P2Wpn
         4sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU38O8CouCTtsIER1W1d/4VZ6DU6HwCBKnyEVnK0EZY=;
        b=0+gZh0bPvgVSB0H5QtzKXEu4nzVsVmIs19l41/CZgRSo/et7AKAeHooUe2gIV7Y9Up
         xMlblMk2ZrXEht62Axnd1Gaa3mIsV6flPaCOSVvPgS+FUloN9vksEuOwr5xqK2ZPlt9B
         GTxB7DF5yCBYjDzxvzWIt+gXDQfly66FeNVbf9lgHWZPemro1bNrLhoZUoYSUte6SO1e
         TQR2vLtYpCsZ2IMJEboybLz+5O7nKvVmdT2U3S6E+YveGkXi3jaM88km6NHvItCM7Dzi
         4dsQC/4SYUEVs7dTWhGz/5DHa8pmtzVFr2uP4d46dyIROO33UZcN4S3RHdMdvp3jADx+
         jI1Q==
X-Gm-Message-State: AO0yUKXCzXQcBUW+QIq0WwNVqJosu5itiwZvAqXakuO2FWSXGlg4YoE6
        Hhx1VW2mU34Coz3e1ETgKiVeujHuAUA=
X-Google-Smtp-Source: AK7set8VyK+WmEjhLBMXGj+ajMtIpf30o5oj7ESKRq8TbUvkxDbnf1p0U/HYvrFPolLIfhuAsRpGNA==
X-Received: by 2002:a17:902:db03:b0:19a:9dab:3438 with SMTP id m3-20020a170902db0300b0019a9dab3438mr8097298plx.2.1676678724905;
        Fri, 17 Feb 2023 16:05:24 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1210? ([2620:10d:c090:400::5:2cec])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b00186a2dd3ffdsm3649114plt.15.2023.02.17.16.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:05:24 -0800 (PST)
Message-ID: <f8ed7a71-626a-a86f-7404-07b2ae44b20d@gmail.com>
Date:   Fri, 17 Feb 2023 16:05:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-5-kuifeng@meta.com>
 <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZ8k04R4Y0FY2k6KoSPZdiYRJxcnA1qypi=Hk-JM8ppWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/16/23 14:40, Andrii Nakryiko wrote:
> On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
>> placeholder, but now it is constructing an authentic one by calling
>> bpf_link_create() if the map has the BPF_F_LINK flag.
>>
>> You can flag a struct_ops map with BPF_F_LINK by calling
>> bpf_map__set_map_flags().
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 58 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 75ed95b7e455..1eff6a03ddd9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
>>          return link;
>>   }
>>
>> +struct bpf_link_struct_ops_map {
> 
> let's drop the "_map" suffix? struct_ops is always a map, so no need
> to point this out

Sure!

> 
>> +       struct bpf_link link;
>> +       int map_fd;
>> +};
>> +
>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>   {
>> +       struct bpf_link_struct_ops_map *st_link;
>>          __u32 zero = 0;
>>
>> -       if (bpf_map_delete_elem(link->fd, &zero))
>> +       st_link = container_of(link, struct bpf_link_struct_ops_map, link);
>> +
>> +       if (st_link->map_fd < 0) {
>> +               /* Fake bpf_link */
>> +               if (bpf_map_delete_elem(link->fd, &zero))
>> +                       return -errno;
>> +               return 0;
>> +       }
>> +
>> +       if (bpf_map_delete_elem(st_link->map_fd, &zero))
>> +               return -errno;
>> +
>> +       if (close(link->fd))
>>                  return -errno;
>>
>>          return 0;
>>   }
>>
>> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>> +/*
>> + * Update the map with the prepared vdata.
>> + */
>> +static int bpf_map__update_vdata(const struct bpf_map *map)
> 
> this is internal helper, so let's not use double underscores, just
> bpf_map_update_vdata()

Ok!

> 
>>   {
>>          struct bpf_struct_ops *st_ops;
>> -       struct bpf_link *link;
>>          __u32 i, zero = 0;
>> -       int err;
>> -
>> -       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>> -               return libbpf_err_ptr(-EINVAL);
>> -
>> -       link = calloc(1, sizeof(*link));
>> -       if (!link)
>> -               return libbpf_err_ptr(-EINVAL);
>>
>>          st_ops = map->st_ops;
>>          for (i = 0; i < btf_vlen(st_ops->type); i++) {
>> @@ -11468,17 +11480,48 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>                  *(unsigned long *)kern_data = prog_fd;
>>          }
>>
>> -       err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> +       return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> +}
>> +
>> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>> +{
>> +       struct bpf_link_struct_ops_map *link;
>> +       int err, fd;
>> +
>> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>> +               return libbpf_err_ptr(-EINVAL);
>> +
>> +       link = calloc(1, sizeof(*link));
>> +       if (!link)
>> +               return libbpf_err_ptr(-EINVAL);
>> +
>> +       err = bpf_map__update_vdata(map);
>>          if (err) {
>>                  err = -errno;
>>                  free(link);
>>                  return libbpf_err_ptr(err);
>>          }
>>
>> -       link->detach = bpf_link__detach_struct_ops;
>> -       link->fd = map->fd;
>> +       link->link.detach = bpf_link__detach_struct_ops;
>>
>> -       return link;
>> +       if (!(map->def.map_flags & BPF_F_LINK)) {
> 
> So this will always require a programmatic bpf_map__set_map_flags()
> call, there is currently no declarative way to do this, right?
> 
> Is there any way to avoid this BPF_F_LINK flag approach? How bad would
> it be if kernel just always created bpf_link-backed struct_ops?
> 
> Alternatively, should we think about SEC(".struct_ops.link") or
> something like that to instruct libbpf to add this BPF_F_LINK flag
> automatically?

Agree!

The other solution is to add a flag when declare a struct_ops.

  SEC(".struct_ops")
  tcp_congestion_ops ops = {
      ...
      .flags = WITH_LINK,
  }


> 
>> +               /* Fake bpf_link */
>> +               link->link.fd = map->fd;
>> +               link->map_fd = -1;
>> +               return &link->link;
>> +       }
>> +
