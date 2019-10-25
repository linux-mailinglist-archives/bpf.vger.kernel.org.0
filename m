Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F068E45B3
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438009AbfJYI12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 04:27:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438006AbfJYI12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 04:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571992047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcI5t6CsVJQabA12BdZ1TYYosDenntzCg3SsjvCibXY=;
        b=JhPv5ImWGuCDMRheD6A3eWczLHOSi1FyBaB9mBHTG2Yn2o0CY42HMH4x9Cswj8/WEQrGlx
        2l6Pid07J3l5WlGGpu7LRqlKGXC7fkkn9rTmNWBlyxkiB5kkhcV47TjBaCN/3asObIOiiw
        JkQDTe8OUU2iX8Z7CxzCok06QwoEpto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-5c6reNZEMcu2u6L7u5k0yQ-1; Fri, 25 Oct 2019 04:27:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D615B1800E00;
        Fri, 25 Oct 2019 08:27:18 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id B8291194B6;
        Fri, 25 Oct 2019 08:27:14 +0000 (UTC)
Date:   Fri, 25 Oct 2019 10:27:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 6/9] perf tools: add destructors for parse event terms
Message-ID: <20191025082714.GH31679@krava>
References: <20191023005337.196160-1-irogers@google.com>
 <20191024190202.109403-1-irogers@google.com>
 <20191024190202.109403-7-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191024190202.109403-7-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5c6reNZEMcu2u6L7u5k0yQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 24, 2019 at 12:01:59PM -0700, Ian Rogers wrote:
> If parsing fails then destructors are ran to clean the up the stack.
> Rename the head union member to make the term and evlist use cases more
> distinct, this simplifies matching the correct destructor.

nice did not know about this.. looks like it's been in bison for some time,=
 right?

>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 69 +++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 21 deletions(-)
>=20
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 545ab7cefc20..4725b14b9db4 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -12,6 +12,7 @@
>  #include <stdio.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> +#include <linux/zalloc.h>
>  #include "pmu.h"
>  #include "evsel.h"
>  #include "parse-events.h"
> @@ -37,6 +38,25 @@ static struct list_head* alloc_list()
>  =09return list;
>  }
> =20
> +static void free_list_evsel(struct list_head* list_evsel)
> +{
> +=09struct perf_evsel *pos, *tmp;
> +
> +=09list_for_each_entry_safe(pos, tmp, list_evsel, node) {
> +=09=09list_del_init(&pos->node);
> +=09=09perf_evsel__delete(pos);
> +=09}
> +=09free(list_evsel);

I think you need to iterate 'struct evsel' in here, not 'struct perf_evsel'

should be:

=09struct evsel *evsel, *tmp;

=09list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
=09=09list_del_init(&evsel->core.node);
=09=09evsel__delete(evsel);
=09}

thanks,
jirka

> +}
> +
> +static void free_term(struct parse_events_term *term)
> +{
> +=09if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> +=09=09free(term->val.str);
> +=09zfree(&term->array.ranges);
> +=09free(term);
> +}
> +
>  static void inc_group_count(struct list_head *list,
>  =09=09       struct parse_events_state *parse_state)
>  {
> @@ -66,6 +86,7 @@ static void inc_group_count(struct list_head *list,
>  %type <num> PE_VALUE_SYM_TOOL
>  %type <num> PE_RAW
>  %type <num> PE_TERM
> +%type <num> value_sym
>  %type <str> PE_NAME
>  %type <str> PE_BPF_OBJECT
>  %type <str> PE_BPF_SOURCE
> @@ -76,37 +97,43 @@ static void inc_group_count(struct list_head *list,
>  %type <str> PE_EVENT_NAME
>  %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
>  %type <str> PE_DRV_CFG_TERM
> -%type <num> value_sym
> -%type <head> event_config
> -%type <head> opt_event_config
> -%type <head> opt_pmu_config
> +%destructor { free ($$); } <str>
>  %type <term> event_term
> -%type <head> event_pmu
> -%type <head> event_legacy_symbol
> -%type <head> event_legacy_cache
> -%type <head> event_legacy_mem
> -%type <head> event_legacy_tracepoint
> +%destructor { free_term ($$); } <term>
> +%type <list_terms> event_config
> +%type <list_terms> opt_event_config
> +%type <list_terms> opt_pmu_config
> +%destructor { parse_events_terms__delete ($$); } <list_terms>
> +%type <list_evsel> event_pmu
> +%type <list_evsel> event_legacy_symbol
> +%type <list_evsel> event_legacy_cache
> +%type <list_evsel> event_legacy_mem
> +%type <list_evsel> event_legacy_tracepoint
> +%type <list_evsel> event_legacy_numeric
> +%type <list_evsel> event_legacy_raw
> +%type <list_evsel> event_bpf_file
> +%type <list_evsel> event_def
> +%type <list_evsel> event_mod
> +%type <list_evsel> event_name
> +%type <list_evsel> event
> +%type <list_evsel> events
> +%type <list_evsel> group_def
> +%type <list_evsel> group
> +%type <list_evsel> groups
> +%destructor { free_list_evsel ($$); } <list_evsel>
>  %type <tracepoint_name> tracepoint_name
> -%type <head> event_legacy_numeric
> -%type <head> event_legacy_raw
> -%type <head> event_bpf_file
> -%type <head> event_def
> -%type <head> event_mod
> -%type <head> event_name
> -%type <head> event
> -%type <head> events
> -%type <head> group_def
> -%type <head> group
> -%type <head> groups
> +%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
>  %type <array> array
>  %type <array> array_term
>  %type <array> array_terms
> +%destructor { free ($$.ranges); } <array>
> =20
>  %union
>  {
>  =09char *str;
>  =09u64 num;
> -=09struct list_head *head;
> +=09struct list_head *list_evsel;
> +=09struct list_head *list_terms;
>  =09struct parse_events_term *term;
>  =09struct tracepoint_name {
>  =09=09char *sys;
> --=20
> 2.23.0.866.gb869b98d4c-goog
>=20

