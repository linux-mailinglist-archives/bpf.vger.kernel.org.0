Return-Path: <bpf+bounces-8983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083678D51B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB32813A7
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94DB3FFB;
	Wed, 30 Aug 2023 10:26:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51246A7
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 10:26:38 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC5C0
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:26:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so50763795e9.0
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693391195; x=1693995995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScR5rqD0o1Tl8V/sWeL0Rl6USAPN1dXwo30U/Hv+ZAk=;
        b=N6cJIRbaGznaRQhBpdsVQmkG1ZGEDzg/4z09MvAAn+ihUdZZWtf0Z3C2pWorGJfFGx
         C8wK/ziOvWflKnaAShlX474/bPqE+yqEdSR2t88XcyE9WrICpn1YRejMT97uCO4+R+4Y
         dqmMYamGQ8YLD/RQ73xqmYPXVGPpQx1aI2TO7v79mke2aM1V8d6iuJELPkLAKM61AYUA
         w/HgmU2x2Gh3cBLrowfXfiaPUuu4IzhyGQozMMWtET7uxtEBfj3mLmsYjbXfxFIGtlWX
         iKgSfr/p/Pv26pEpPBTl87Zjm2Xd6CvIQjsUu3KqRjLaSbYJEOXU2m/7oKFhI/dSOnm7
         tjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391195; x=1693995995;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScR5rqD0o1Tl8V/sWeL0Rl6USAPN1dXwo30U/Hv+ZAk=;
        b=bxVcJh3p3zR5w2usW1WfYCj737ZSV/f5DHnT9ij+YkwrrgblpcYW9YIzuEekdmMKgx
         1dsXMAAxuRznly8Kd2tKFKE9oR0kYvqAI6HDYtDiw+ESvwn6KQf+vqGTjoR939Vow8G8
         XA226WYGsbvdY/nKb+ez+JtAfdqkVyojQ1jcPeUCsrqUYgDIbkpenamgvMBPTtKpXUnN
         200mX2slCnCZTs6DgdQDm3kpJ/sG7YvZdIIRb0ZuEZ6BnnYwZp0724BkrFdHuixnbz1e
         L6w8txEQXo5EbYqL0OmkHgkMS2n5JJy1qXthH5MiqLZGnq0Dk8Ez6fzWOYxi56zgoBN0
         n9tQ==
X-Gm-Message-State: AOJu0Yye2mHTYsGxVkDTNxl+SvaLS74tJnHGfYL/hxxyE/TLpJ9/FOZc
	eWsbLaL4psSZAI/kTk03ga6wFqZgOn1fBixPrtvzxQ==
X-Google-Smtp-Source: AGHT+IGUQ8vx+iEj/OqH5yNZ8NV0o1rXG3mTrpsfWxYC8n0PTwFgOYH4G1mCXCDLUiYcvh0TeBFfVA==
X-Received: by 2002:a1c:7c11:0:b0:3fe:1cac:37d5 with SMTP id x17-20020a1c7c11000000b003fe1cac37d5mr1678072wmc.4.1693391194904;
        Wed, 30 Aug 2023 03:26:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca? ([2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c21c100b003fe3674bb39sm1820973wmj.2.2023.08.30.03.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:26:34 -0700 (PDT)
Message-ID: <80fa41b6-4206-4309-958d-7f931afc2e85@isovalent.com>
Date: Wed, 30 Aug 2023 11:26:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Support dumping BTF object by name
Content-Language: en-GB
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
References: <20230828140425.466174-1-hengqi.chen@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230828140425.466174-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/08/2023 15:04, Hengqi Chen wrote:
> Like maps and progs, add support to dump BTF
> objects by name ([0]).

Hi, thanks for looking into this!

Can we also please support referencing by name for "bpftool btf list"?
This will require collecting a list of the different programs with a
matching name, like we do for "bpftool prog list name <foo>" (but dumps
should still fail if there are more than one program matching, for
consistency with "bpftool prog dump").

> 
>   [0] Closes: https://github.com/libbpf/bpftool/issues/56
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c | 92 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..cb8d78ff4081 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -547,6 +547,83 @@ static bool btf_is_kernel_module(__u32 btf_id)
>  	return btf_info.kernel_btf && strncmp(btf_name, "vmlinux", sizeof(btf_name)) != 0;
>  }
> 
> +static int btf_id_by_name(char *name, __u32 *btf_id)
> +{
> +	bool found = false;
> +	__u32 id = 0;
> +	int fd, err;
> +
> +	while (true) {
> +		struct bpf_btf_info info = {};
> +		__u32 len = sizeof(info);

"info_len" instead of "len" would be more explicit, and this can
probably be a const.

> +		char btf_name[64];
> +
> +		err = bpf_btf_get_next_id(id, &id);
> +		if (err) {
> +			if (errno == ENOENT) {
> +				if (found)
> +					err = 0;
> +				else
> +					p_err("no BTF object match name %s", name);
> +				break;
> +			}
> +
> +			p_err("can't get next BTF object: %s%s",
> +			      strerror(errno),
> +			      errno == EINVAL ? " -- kernel too old?" : "");
> +			return -1;
> +		}
> +
> +		fd = bpf_btf_get_fd_by_id(id);
> +		if (fd < 0) {
> +			p_err("can't get BTF by id (%u): %s",
> +			      id, strerror(errno));
> +			return -1;
> +		}
> +
> +		err = bpf_btf_get_info_by_fd(fd, &info, &len);
> +		if (err) {
> +			p_err("can't get BTF info (%u): %s",
> +			      id, strerror(errno));
> +			goto err_close_fd;
> +		}
> +
> +		if (info.name_len) {
> +			memset(&info, 0, sizeof(info));
> +			info.name_len = sizeof(btf_name);
> +			info.name = ptr_to_u64(btf_name);
> +			len = sizeof(info);

sizeof(info) is the same as before, no need to reassign "len" (and we
can use "len" in the memset()).

> +
> +			err = bpf_btf_get_info_by_fd(fd, &info, &len);
> +			if (err) {
> +				p_err("can't get BTF info (%u): %s",
> +				      id, strerror(errno));
> +				goto err_close_fd;
> +			}
> +		}
> +
> +		close(fd);
> +
> +		if (strncmp(name, u64_to_ptr(info.name), BPF_OBJ_NAME_LEN))

There's no guarantee that "info.name" is set, here. Some BTF objects are
anonymous and won't have a name. I'm getting a segfault from this
strncmp() when trying the patch locally, because I've got anonymous BTF
objects loaded and I end up passing a null pointer to the function. Can
you please fix this?

A follow-up question is how to handle anonymous objects. Given that
we want to filter on names, we should probably allow empty name as well:
"bpftool btf list name ''" should list anonymous objects, what do you
think?

> +			continue;
> +
> +		if (found) {
> +			p_err("multiple BTF object match name %s", name);
> +			return -1;
> +		}
> +
> +		*btf_id = id;
> +		found = true;
> +	}
> +
> +	return err;
> +
> +err_close_fd:
> +	close(fd);
> +	return err;
> +}
> +
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	struct btf *btf = NULL, *base = NULL;
> @@ -637,6 +714,19 @@ static int do_dump(int argc, char **argv)
>  			      *argv, strerror(errno));
>  			goto done;
>  		}
> +		NEXT_ARG();
> +	} else if (is_prefix(src, "name")) {
> +		char *name = *argv;
> +
> +		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
> +			p_err("can't parse name");
> +			return -1;
> +		}
> +
> +		err = btf_id_by_name(name, &btf_id);
> +		if (err)
> +			return -1;
> +
>  		NEXT_ARG();
>  	} else {
>  		err = -1;
> @@ -1062,7 +1152,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
> -		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
> +		"       BTF_SRC := { id BTF_ID | name NAME | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"

We will also need to update the command description in the relevant man
page (.../Documentation/bpftool-btf.rst), and the bash completion
(.../bash-completion/bpftool).

Here's what I'd suggest for the bash completion:

------
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 085bf18f3659..9aa0d2efe938 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -98,6 +98,12 @@ _bpftool_get_btf_ids()
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
+_bpftool_get_btf_names()
+{
+    COMPREPLY+=( $( compgen -W "$( bpftool -jp btf 2>&1 | \
+        command sed -n 's/.*"name": "\(.*\)",\?$/\1/p' )" -- "$cur" ) )
+}
+
 _bpftool_get_link_ids()
 {
     COMPREPLY+=( $( compgen -W "$( bpftool -jp link 2>&1 | \
@@ -899,7 +905,7 @@ _bpftool()
                 dump)
                     case $prev in
                         $command)
-                            COMPREPLY+=( $( compgen -W "id map prog file" -- \
+                            COMPREPLY+=( $( compgen -W "id map name prog file" -- \
                                 "$cur" ) )
                             return 0
                             ;;
@@ -933,6 +939,9 @@ _bpftool()
                                 map)
                                     _bpftool_get_map_names
                                     ;;
+                                $command)
+                                    _bpftool_get_btf_names
+                                    ;;
                             esac
                             return 0
                             ;;
@@ -961,11 +970,14 @@ _bpftool()
                 show|list)
                     case $prev in
                         $command)
-                            COMPREPLY+=( $( compgen -W "id" -- "$cur" ) )
+                            COMPREPLY+=( $( compgen -W "id name" -- "$cur" ) )
                             ;;
                         id)
                             _bpftool_get_btf_ids
                             ;;
+                        name)
+                            _bpftool_get_btf_names
+                            ;;
                     esac
                     return 0
                     ;;
------

Please also make sure to Cc the other BPF maintainers for your next
version.

Thanks,
Quentin

