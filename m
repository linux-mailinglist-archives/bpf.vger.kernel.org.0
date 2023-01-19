Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB01674209
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjASTFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjASTFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 14:05:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B34AA41
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 11:04:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r9so2807374wrw.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bagGf68ry1JpnwUnvUmcScyJ7gubFGzB5rLy+GIW+8o=;
        b=Lng8WB8mNVBoxfvrWFqe/ikPrxiqLnUVY+IlWZrUeFSnrEwGf8PQ2OSEZTbUoOIxIE
         yp5GE7dz1OlvzCPE9TS5VjLyoxAwaMZCEIoP0SZg1kMHCCa/10c+q6CwO5wq8UNYkUYh
         wFyujVatb6VulfkDnKiTp//G4JCu3dunSo1DaeIA50eCsOqBLJ0jdNRSbG9BNVwNQOP/
         AGq1pS6ktFJQQWoB7HYUQGvtjxkNQBrJO8aF97LWtZJsc076PW9jvie+lTQZ9fXGMjDS
         zxMxRNcyvHCAJgg0eUyoKBl5LHOTZSOnU93hmqE9TrMPOyVUWv/CcfMTLhJoLNvHfVXW
         2FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bagGf68ry1JpnwUnvUmcScyJ7gubFGzB5rLy+GIW+8o=;
        b=6lVHHdmscKqBfgsuwz8VzRA0P6eya7Z6yERoky/EkopCqLZr+ZoLrbr3hwyTmjb9vj
         T2MK4HtC9qRI4rx6cXkoWuRvUIKiVW9m7LKPuAic+qTxb5BjOZYZMWmVIJE+vhktRygm
         MoZF0sPMd+1LpPOuhzReX0j3Zk6doeREqsiiZ62UGUXRm9bPsPAe+h5n4wDkV89TaEDY
         byHRZMHIYNoVaJlDFqJ5OMhFyTflh2ddVxUiWNKiD47AR4nYNvy3ryhXrvtA0ynTcI1I
         lKiorRPPXjogOU2KOgQ5P1fVCxvUAsYLONhVo5+IOoAv2aiBKK8zPKfpddfCi5wq9GAm
         VTAg==
X-Gm-Message-State: AFqh2kpaV4OAT4cDgHg/rOfFL+ogeaJvUqfItV/1Jdn10GcnS9UPRo28
        5S16P2m8mfO3I1Q+2ba7W6HvR83HLXs2rtg8yCfDMQ==
X-Google-Smtp-Source: AMrXdXvTbpMyodd9JEqQHJBir1fi+EoHAfCdibnzLye5PKbc80ZS7WAGOSZ37YLGZY+MXuaY36zb5aZsWcHktYC9Nn0=
X-Received: by 2002:adf:e2cd:0:b0:2bd:f8da:9be0 with SMTP id
 d13-20020adfe2cd000000b002bdf8da9be0mr407328wrj.375.1674154963570; Thu, 19
 Jan 2023 11:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119183118.126387-1-irogers@google.com>
In-Reply-To: <20230119183118.126387-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 11:02:31 -0800
Message-ID: <CAP-5=fXsG06+j9bOyWTUK_wXJTZP0cvy=9hD6DFFuc3HQefyOg@mail.gmail.com>
Subject: Re: [PATCH v3] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 10:31 AM Ian Rogers <irogers@google.com> wrote:
>
> Currently flame graph generation requires a d3-flame-graph template to
> be installed. Unfortunately this is hard to come by for things like
> Debian [1]. If the template isn't installed then ask if it should be
> downloaded from jsdelivr CDN. The downloaded HTML file is validated
> against an md5sum. If the download fails, generate a minimal flame
> graph with the javascript coming from links to jsdelivr CDN.
>
> v3. Adds a warning message and quits before download in live mode.
> v2. Change the warning to a prompt about downloading and add the
>     --allow-download command line flag. Add an md5sum check for the
>     downloaded HTML.
>
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
>
> Signed-off-by: Ian Rogers <irogers@google.com>


Apologies, please ignore this patch. I accidentally picked this merged
change up with a wild card.

Thanks,
Ian

> ---
>  tools/perf/scripts/python/flamegraph.py | 107 +++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index b6af1dd5f816..cf7ce8229a6c 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -19,12 +19,34 @@
>  # pylint: disable=missing-function-docstring
>
>  from __future__ import print_function
> -import sys
> -import os
> -import io
>  import argparse
> +import hashlib
> +import io
>  import json
> +import os
>  import subprocess
> +import sys
> +import urllib.request
> +
> +minimal_html = """<head>
> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> +</head>
> +<body>
> +  <div id="chart"></div>
> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> +  <script type="text/javascript">
> +  const stacks = [/** @flamegraph_json **/];
> +  // Note, options is unused.
> +  const options = [/** @options_json **/];
> +
> +  var chart = flamegraph();
> +  d3.select("#chart")
> +        .datum(stacks[0])
> +        .call(chart);
> +  </script>
> +</body>
> +"""
>
>  # pylint: disable=too-few-public-methods
>  class Node:
> @@ -50,16 +72,6 @@ class FlameGraphCLI:
>          self.args = args
>          self.stack = Node("all", "root")
>
> -        if self.args.format == "html" and \
> -                not os.path.isfile(self.args.template):
> -            print("Flame Graph template {} does not exist. Please install "
> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> -                  "package, specify an existing flame graph template "
> -                  "(--template PATH) or another output format "
> -                  "(--format FORMAT).".format(self.args.template),
> -                  file=sys.stderr)
> -            sys.exit(1)
> -
>      @staticmethod
>      def get_libtype_from_dso(dso):
>          """
> @@ -128,16 +140,63 @@ class FlameGraphCLI:
>              }
>              options_json = json.dumps(options)
>
> +            template_md5sum = None
> +            if self.args.format == "html":
> +                if os.path.isfile(self.args.template):
> +                    template = f"file://{self.args.template}"
> +                else:
> +                    if not self.args.allow_download:
> +                        print(f"""Warning: Flame Graph template '{self.args.template}'
> +does not exist. To avoid this please install a package such as the
> +js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> +graph template (--template PATH) or use another output format (--format
> +FORMAT).""",
> +                              file=sys.stderr)
> +                        if self.args.input == "-":
> +                            print("""Not attempting to download Flame Graph template as script command line
> +input is disabled due to using live mode. If you want to download the
> +template retry without live mode. For example, use 'perf record -a -g
> +-F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
> +download the template from:
> +https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html
> +and place it at:
> +/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
> +                                  file=sys.stderr)
> +                            quit()
> +                        s = None
> +                        while s != "y" and s != "n":
> +                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
> +                        if s == "n":
> +                            quit()
> +                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> +                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
> +
>              try:
> -                with io.open(self.args.template, encoding="utf-8") as template:
> -                    output_str = (
> -                        template.read()
> -                        .replace("/** @options_json **/", options_json)
> -                        .replace("/** @flamegraph_json **/", stacks_json)
> -                    )
> -            except IOError as err:
> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> -                sys.exit(1)
> +                with urllib.request.urlopen(template) as template:
> +                    output_str = "".join([
> +                        l.decode("utf-8") for l in template.readlines()
> +                    ])
> +            except Exception as err:
> +                print(f"Error reading template {template}: {err}\n"
> +                      "a minimal flame graph will be generated", file=sys.stderr)
> +                output_str = minimal_html
> +                template_md5sum = None
> +
> +            if template_md5sum:
> +                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
> +                if download_md5sum != template_md5sum:
> +                    s = None
> +                    while s != "y" and s != "n":
> +                        s = input(f"""Unexpected template md5sum.
> +{download_md5sum} != {template_md5sum}, for:
> +{output_str}
> +continue?[yn] """).lower()
> +                    if s == "n":
> +                        quit()
> +
> +            output_str = output_str.replace("/** @options_json **/", options_json)
> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> +
>              output_fn = self.args.output or "flamegraph.html"
>          else:
>              output_str = stacks_json
> @@ -172,6 +231,10 @@ if __name__ == "__main__":
>                          choices=["blue-green", "orange"])
>      parser.add_argument("-i", "--input",
>                          help=argparse.SUPPRESS)
> +    parser.add_argument("--allow-download",
> +                        default=False,
> +                        action="store_true",
> +                        help="allow unprompted downloading of HTML template")
>
>      cli_args = parser.parse_args()
>      cli = FlameGraphCLI(cli_args)
> --
> 2.39.0.314.g84b9a713c41-goog
>
