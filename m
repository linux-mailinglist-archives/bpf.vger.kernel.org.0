Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6924D10B
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgHUI6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 04:58:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36203 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727780AbgHUI6V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598000299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziEoTo8ZoHprDuRWF1bzb6He+ksT/wDyO0j9XDvpjLU=;
        b=AxVLX2eEola5XqJ1DJbHCrTUlbHeB5ArfgxTJc1BRxiu4dqqWHa/pGLn066Y6iCZvEfEMz
        fpFGEkxidzIJzlegF9ppfcSV2X2XH7ykUpdgCYSVecnP/pVhOc6vnjRCnM0fUKKQSUSbep
        fVRUllW/5aNn3v0UoSIWe+Ouax8tDPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-XcG-HR9iMPGao-T2uznBlQ-1; Fri, 21 Aug 2020 04:58:17 -0400
X-MC-Unique: XcG-HR9iMPGao-T2uznBlQ-1
Received: by mail-wr1-f70.google.com with SMTP id z1so339005wrn.18
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 01:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ziEoTo8ZoHprDuRWF1bzb6He+ksT/wDyO0j9XDvpjLU=;
        b=bcAU9fVgeohZkJm8z8mHTUk3MUXeaRqa5FSrtJjcfwtMYwsqWtFd8IaJf0Xi47DIBj
         mXte9zKJuC/xQIuxiOGKPaBW1JLHk59mW8o2gviwNVf/sNDwGE74MeNJczxqp5XlVuJO
         SZhNgrNlXUYbuXBUTeAvqPubBVXCdXHtpAmW3hkZv2lYNWGCWYD12ks2BBdEUtKKLpTE
         pT/EZqZQsyywD3Uq8oZ9k0YAMYjfCr6Qurc1tu0vApEutXfvW8QzK9sVj0SQ0w/ikN4P
         pkjywnHcIRToIiY6cdS4wDlou730WmytcpriNbP9DIvNhikfHgABxoxdBol6IWQ/0hta
         I5ww==
X-Gm-Message-State: AOAM533QCkJVG1rLjpwUIRkywhxCk9pYpx9GBkKfVuGtTlQxs1ZZLh1e
        IHdICEqrHNhU0+BbWMVJdi1Ez9QObk7tsB1SkOuiuAgTlJZ+iIH4cHow11h/KF5R6yRRz/c/qMV
        z0g9vNLGMLq+y
X-Received: by 2002:adf:f189:: with SMTP id h9mr1789876wro.122.1598000295901;
        Fri, 21 Aug 2020 01:58:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+SPwqgk+HR7EIkKMpWg9c81hDo2qCrla5SKzoei0KZoxD0qtj7R1mLory7mEvAJP5ANj8BQ==
X-Received: by 2002:adf:f189:: with SMTP id h9mr1789858wro.122.1598000295598;
        Fri, 21 Aug 2020 01:58:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n24sm3299867wmi.36.2020.08.21.01.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 01:58:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6B35D1816A2; Fri, 21 Aug 2020 10:58:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>, YiFei Zhu <zhuyifei1999@gmail.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
In-Reply-To: <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 10:58:14 +0200
Message-ID: <877dts5qah.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 8/20/20 2:42 AM, YiFei Zhu wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>> 
>> Added a flag "--metadata" to `bpftool prog list` to dump the metadata
>> contents. For some formatting some BTF code is put directly in the
>> metadata dumping. Sanity checks on the map and the kind of the btf_type
>> to make sure we are actually dumping what we are expecting.
>> 
>> A helper jsonw_reset is added to json writer so we can reuse the same
>> json writer without having extraneous commas.
>> 
>> Sample output:
>> 
>>    $ bpftool prog --metadata
>>    6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
>>    [...]
>>    	btf_id 4
>>    	metadata:
>>    		metadata_a = "foo"
>>    		metadata_b = 1
>> 
>>    $ bpftool prog --metadata --json --pretty
>>    [{
>>            "id": 6,
>>    [...]
>>            "btf_id": 4,
>>            "metadata": {
>>                "metadata_a": "foo",
>>                "metadata_b": 1
>>            }
>>        }
>>    ]
>> 
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> ---
>>   tools/bpf/bpftool/json_writer.c |   6 ++
>>   tools/bpf/bpftool/json_writer.h |   3 +
>>   tools/bpf/bpftool/main.c        |  10 +++
>>   tools/bpf/bpftool/main.h        |   1 +
>>   tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
>>   5 files changed, 155 insertions(+)
>> 
>> diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
>> index 86501cd3c763..7fea83bedf48 100644
>> --- a/tools/bpf/bpftool/json_writer.c
>> +++ b/tools/bpf/bpftool/json_writer.c
>> @@ -119,6 +119,12 @@ void jsonw_pretty(json_writer_t *self, bool on)
>>   	self->pretty = on;
>>   }
>>   
>> +void jsonw_reset(json_writer_t *self)
>> +{
>> +	assert(self->depth == 0);
>> +	self->sep = '\0';
>> +}
>> +
>>   /* Basic blocks */
>>   static void jsonw_begin(json_writer_t *self, int c)
>>   {
>> diff --git a/tools/bpf/bpftool/json_writer.h b/tools/bpf/bpftool/json_writer.h
>> index 35cf1f00f96c..8ace65cdb92f 100644
>> --- a/tools/bpf/bpftool/json_writer.h
>> +++ b/tools/bpf/bpftool/json_writer.h
>> @@ -27,6 +27,9 @@ void jsonw_destroy(json_writer_t **self_p);
>>   /* Cause output to have pretty whitespace */
>>   void jsonw_pretty(json_writer_t *self, bool on);
>>   
>> +/* Reset separator to create new JSON */
>> +void jsonw_reset(json_writer_t *self);
>> +
>>   /* Add property name */
>>   void jsonw_name(json_writer_t *self, const char *name);
>>   
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index 4a191fcbeb82..a681d568cfa7 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -28,6 +28,7 @@ bool show_pinned;
>>   bool block_mount;
>>   bool verifier_logs;
>>   bool relaxed_maps;
>> +bool dump_metadata;
>>   struct pinned_obj_table prog_table;
>>   struct pinned_obj_table map_table;
>>   struct pinned_obj_table link_table;
>> @@ -351,6 +352,10 @@ static int do_batch(int argc, char **argv)
>>   	return err;
>>   }
>>   
>> +enum bpftool_longonly_opts {
>> +	OPT_METADATA = 256,
>> +};
>> +
>>   int main(int argc, char **argv)
>>   {
>>   	static const struct option options[] = {
>> @@ -362,6 +367,7 @@ int main(int argc, char **argv)
>>   		{ "mapcompat",	no_argument,	NULL,	'm' },
>>   		{ "nomount",	no_argument,	NULL,	'n' },
>>   		{ "debug",	no_argument,	NULL,	'd' },
>> +		{ "metadata",	no_argument,	NULL,	OPT_METADATA },
>>   		{ 0 }
>>   	};
>>   	int opt, ret;
>> @@ -371,6 +377,7 @@ int main(int argc, char **argv)
>>   	json_output = false;
>>   	show_pinned = false;
>>   	block_mount = false;
>> +	dump_metadata = false;
>>   	bin_name = argv[0];
>>   
>>   	hash_init(prog_table.table);
>> @@ -412,6 +419,9 @@ int main(int argc, char **argv)
>>   			libbpf_set_print(print_all_levels);
>>   			verifier_logs = true;
>>   			break;
>> +		case OPT_METADATA:
>> +			dump_metadata = true;
>> +			break;
>>   		default:
>>   			p_err("unrecognized option '%s'", argv[optind - 1]);
>>   			if (json_output)
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index c46e52137b87..8750758e9150 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -90,6 +90,7 @@ extern bool show_pids;
>>   extern bool block_mount;
>>   extern bool verifier_logs;
>>   extern bool relaxed_maps;
>> +extern bool dump_metadata;
>>   extern struct pinned_obj_table prog_table;
>>   extern struct pinned_obj_table map_table;
>>   extern struct pinned_obj_table link_table;
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index d393eb8263a6..ee767b8d90fb 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -151,6 +151,135 @@ static void show_prog_maps(int fd, __u32 num_maps)
>>   	}
>>   }
>>   
>> +static void show_prog_metadata(int fd, __u32 num_maps)
>> +{
>> +	struct bpf_prog_info prog_info = {};
>> +	struct bpf_map_info map_info = {};
>> +	__u32 prog_info_len = sizeof(prog_info);
>> +	__u32 map_info_len = sizeof(map_info);
>> +	__u32 map_ids[num_maps];
>> +	void *value = NULL;
>> +	struct btf *btf = NULL;
>> +	const struct btf_type *t_datasec, *t_var;
>> +	struct btf_var_secinfo *vsi;
>> +	int key = 0;
>> +	unsigned int i, vlen;
>> +	int map_fd;
>> +	int err;
>
> try to follow reverse christmas tree coding styple?
>
>> +
>> +	prog_info.nr_map_ids = num_maps;
>> +	prog_info.map_ids = ptr_to_u64(map_ids);
>> +
>> +	err = bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
>> +	if (err || !prog_info.nr_map_ids)
>> +		return;
>
> print out something for "err" case and "!prog_info.nr_map_ids" case?
> The same for some other below returns.
>
>> +
>> +	for (i = 0; i < prog_info.nr_map_ids; i++) {
>> +		map_fd = bpf_map_get_fd_by_id(map_ids[i]);
>> +		if (map_fd < 0)
>> +			return;
>> +
>> +		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
>> +		if (err)
>> +			goto out_close;
>> +
>> +		if (map_info.type != BPF_MAP_TYPE_ARRAY)
>> +			goto next_map;
>> +		if (map_info.key_size != sizeof(int))
>> +			goto next_map;
>> +		if (map_info.max_entries != 1)
>> +			goto next_map;
>> +		if (!map_info.btf_value_type_id)
>> +			goto next_map;
>> +		if (!strstr(map_info.name, ".metadata"))
>> +			goto next_map;
>> +
>> +		goto found;
>> +
>> +next_map:
>> +		close(map_fd);
>> +	}
>> +
>> +	return;
>> +
>> +found:
>> +	value = malloc(map_info.value_size);
>> +	if (!value)
>> +		goto out_close;
>> +
>> +	if (bpf_map_lookup_elem(map_fd, &key, value))
>> +		goto out_free;
>
> Not sure whether we need formal libbpf API to access metadata or not.
> This may help other applications too. But we can delay until it is
> necessary.

Yeah, please put in a libbpf accessor as well; I would like to use this
from libxdp - without a skeleton :)

-Toke

