Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19B5AAC4B
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 12:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiIBKXM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBKXM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 06:23:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFCA59BB
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 03:23:10 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJv5G4PRhzRhxY;
        Fri,  2 Sep 2022 18:18:42 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 18:23:07 +0800
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
To:     Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
 <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <d17a51a0-954f-7c77-7172-9ef5b3bb84f7@huawei.com>
Date:   Fri, 2 Sep 2022 18:23:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

On 2022/8/26 18:45, Quentin Monnet wrote:
> Hi Andrii,
> 
> On 25/08/2022 19:37, Andrii Nakryiko wrote:
>> On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>> Hi Wei,
>>>
>>> Apologies for failing to answer to your previous email and for the delay
>>> on this one, I just found out GMail had classified them as spam :(.
>>>
>>> So as for your last message, yes: your understanding of my previous
>>> answer was correct. Thanks for the patch below! Some comments inline.
>>>
>>
>> Do we really want to add such a specific command to bpftool that would
>> attach BPF object files with programs of only RAW_TRACEPOINT and
>> RAW_TRACEPOINT_WRITABLE type?
>>
>> I could understand if we added something that would be equivalent of
>> BPF skeleton's auto-attach method. That would make sense in some
>> contexts, especially for some quick testing and validation, to avoid
>> writing (a rather simple) user-space loading code.
> 
> Do you mean loading and attaching in a single step, or keeping the
> possibility to load first as in the current proposal?
> 
>>
>> But "perf attach" for raw_tp programs only? Seem way too limited and
>> specific, just adding bloat to bpftool, IMO.
> 
> We already support attaching some kinds of program types through
> "prog|cgroup|net attach". Here I thought we could add support for other
> types as a follow-up, but thinking again, you're probably right, it
> would be best if all the types were supported from the start. Wei, have
> you looked into how much work it would be to add support for
> tracepoints, k(ret)probes, u(ret)probes as well? The code should be
> mostly identical?
> 


When I try to add others support, I found that we need to dup many code
with libbpf has already done, since we lost the section name info.

I have tried to add auto-attach, it seems more easier then perf
attach command.

What's about your opinion?

Maybe we only need a little of changes like this:

$ bpftool prog load test.o /sys/fs/bpf/test auto-attach


diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index c81362a001ba..87fab89eaa07 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1464,6 +1464,7 @@ static int load_with_options(int argc, char 
**argv, bool first_prog_only)
  	struct bpf_program *prog = NULL, *pos;
  	unsigned int old_map_fds = 0;
  	const char *pinmaps = NULL;
+	bool auto_attach = false;
  	struct bpf_object *obj;
  	struct bpf_map *map;
  	const char *pinfile;
@@ -1472,7 +1473,6 @@ static int load_with_options(int argc, char 
**argv, bool first_prog_only)
  	const char *file;
  	int idx, err;

-
  	if (!REQ_ARGS(2))
  		return -1;
  	file = GET_ARG();
@@ -1583,6 +1583,9 @@ static int load_with_options(int argc, char 
**argv, bool first_prog_only)
  				goto err_free_reuse_maps;

  			pinmaps = GET_ARG();
+		} else if (is_prefix(*argv, "auto-attach")) {
+			auto_attach = true;
+			NEXT_ARG();
  		} else {
  			p_err("expected no more arguments, 'type', 'map' or 'dev', got: '%s'?",
  			      *argv);
@@ -1692,13 +1695,17 @@ static int load_with_options(int argc, char 
**argv, bool first_prog_only)
  			goto err_close_obj;
  		}

-		err = bpf_obj_pin(bpf_program__fd(prog), pinfile);
+		bpf_program__set_autoattach(prog, auto_attach);
+		err = bpf_program__pin(prog, pinfile);
  		if (err) {
  			p_err("failed to pin program %s",
  			      bpf_program__section_name(prog));
  			goto err_close_obj;
  		}
  	} else {
+		bpf_object__for_each_program(prog, obj) {
+			bpf_program__set_autoattach(prog, auto_attach);
+		}
  		err = bpf_object__pin_programs(obj, pinfile);
  		if (err) {
  			p_err("failed to pin all programs");
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3ad139285fad..915ec0a97583 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7773,15 +7773,32 @@ int bpf_program__pin(struct bpf_program *prog, 
const char *path)
  	if (err)
  		return libbpf_err(err);

-	if (bpf_obj_pin(prog->fd, path)) {
-		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, cp);
-		return libbpf_err(err);
+	if (prog->autoattach) {
+		struct bpf_link *link;
+
+		link = bpf_program__attach(prog);
+		err = libbpf_get_error(link);
+		if (err)
+			goto err_out;
+
+		err = bpf_link__pin(link, path);
+		if (err) {
+			bpf_link__destroy(link);
+			goto err_out;
+		}
+	} else {
+		if (bpf_obj_pin(prog->fd, path)) {
+			err = -errno;
+			goto err_out;
+		}
  	}

  	pr_debug("prog '%s': pinned at '%s'\n", prog->name, path);
  	return 0;
+err_out:
+	cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
+	pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, cp);
+	return libbpf_err(err);
  }

  int bpf_program__unpin(struct bpf_program *prog, const char *path)






