Return-Path: <bpf+bounces-16395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330F800EC4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB7281B30
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1738F4AF9E;
	Fri,  1 Dec 2023 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LW9AEKQH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967A194;
	Fri,  1 Dec 2023 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ju0e9bhxfFKrVDGBd6wlWel0hwJujeGJDjh5JGs5sw0=; b=LW9AEKQHAe6noKePc7zb4PRH5a
	hEmImOySMLiJX+5dAlYVRQqNcxPuE3qUSVGFsrFvhEr4C8FQb9Lu1U5NhCDpxIOU/O6Z7mwclUjlz
	qO8PmZ611TeNybfTpbwEM9QCKN9sBoa8oktEhrMKOSzqGuMzAWTl2xl20KBFzVMg4lVwVOnfyiiSE
	NPndgckNLPpWdCJ2sjdbUkkysi/DoI3msjRE8Hr2/sEAA2TWborII+I8v0PJwsvvrGAjtjaO++wua
	Iy+aF9g3SDcDx1K7mVKqDvy+eB/S/Y6/JashfGiQ9IZR/oKqUqjjsqr0r2yVVrSkUaCavtTPBRMrx
	tCqNn3Bw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r95ih-0008Ky-Uc; Fri, 01 Dec 2023 16:46:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r95ih-000Dhk-58; Fri, 01 Dec 2023 16:46:23 +0100
Subject: Re: [PATCH] scripts/bpf_doc: add __main__ judgement before main code
To: Hu Haowen <2023002089@link.tyut.edu.cn>, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, martin.lau@linux.dev
Cc: ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231130145746.23621-1-2023002089@link.tyut.edu.cn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e7286e2d-76ea-8b50-54bd-751b649f9a4e@iogearbox.net>
Date: Fri, 1 Dec 2023 16:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231130145746.23621-1-2023002089@link.tyut.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27110/Fri Dec  1 09:44:56 2023)

Hi Hu,

On 11/30/23 3:57 PM, Hu Haowen wrote:
> When doing Python programming it is a nice convention to insert the if
> statement `if __name__ == "__main__":` before any main code that does
> actual functionalities to ensure the code will be executed only as a
> script rather than as an imported module.  Hence attach the missing
> judgement to bpf_doc.py.
> 
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>

Thanks for the patch. What's the concrete value of this one? Do you plan
to distribute the bpf_docs.py outside of the kernel tree? If it's not
needed feels somewhat too much churn/marginal value.

>   scripts/bpf_doc.py | 81 +++++++++++++++++++++++-----------------------
>   1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 61b7dddedc46..af2a87d97832 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -851,43 +851,44 @@ class PrinterHelpers(Printer):
>   
>   ###############################################################################
>   
> -# If script is launched from scripts/ from kernel tree and can access
> -# ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
> -# otherwise the --filename argument will be required from the command line.
> -script = os.path.abspath(sys.argv[0])
> -linuxRoot = os.path.dirname(os.path.dirname(script))
> -bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
> -
> -printers = {
> -        'helpers': PrinterHelpersRST,
> -        'syscall': PrinterSyscallRST,
> -}
> -
> -argParser = argparse.ArgumentParser(description="""
> -Parse eBPF header file and generate documentation for the eBPF API.
> -The RST-formatted output produced can be turned into a manual page with the
> -rst2man utility.
> -""")
> -argParser.add_argument('--header', action='store_true',
> -                       help='generate C header file')
> -if (os.path.isfile(bpfh)):
> -    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
> -                           default=bpfh)
> -else:
> -    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
> -argParser.add_argument('target', nargs='?', default='helpers',
> -                       choices=printers.keys(), help='eBPF API target')
> -args = argParser.parse_args()
> -
> -# Parse file.
> -headerParser = HeaderParser(args.filename)
> -headerParser.run()
> -
> -# Print formatted output to standard output.
> -if args.header:
> -    if args.target != 'helpers':
> -        raise NotImplementedError('Only helpers header generation is supported')
> -    printer = PrinterHelpers(headerParser)
> -else:
> -    printer = printers[args.target](headerParser)
> -printer.print_all()
> +if __name__ == "__main__":
> +    # If script is launched from scripts/ from kernel tree and can access
> +    # ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
> +    # otherwise the --filename argument will be required from the command line.
> +    script = os.path.abspath(sys.argv[0])
> +    linuxRoot = os.path.dirname(os.path.dirname(script))
> +    bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
> +
> +    printers = {
> +            'helpers': PrinterHelpersRST,
> +            'syscall': PrinterSyscallRST,
> +    }
> +
> +    argParser = argparse.ArgumentParser(description="""
> +    Parse eBPF header file and generate documentation for the eBPF API.
> +    The RST-formatted output produced can be turned into a manual page with the
> +    rst2man utility.
> +    """)
> +    argParser.add_argument('--header', action='store_true',
> +                           help='generate C header file')
> +    if (os.path.isfile(bpfh)):
> +        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
> +                               default=bpfh)
> +    else:
> +        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
> +    argParser.add_argument('target', nargs='?', default='helpers',
> +                           choices=printers.keys(), help='eBPF API target')
> +    args = argParser.parse_args()
> +
> +    # Parse file.
> +    headerParser = HeaderParser(args.filename)
> +    headerParser.run()
> +
> +    # Print formatted output to standard output.
> +    if args.header:
> +        if args.target != 'helpers':
> +            raise NotImplementedError('Only helpers header generation is supported')
> +        printer = PrinterHelpers(headerParser)
> +    else:
> +        printer = printers[args.target](headerParser)
> +    printer.print_all()
> 


